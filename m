Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C168AF2
	for <linux-block@vger.kernel.org>; Tue, 12 Dec 2023 17:02:20 -0800 (PST)
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6cea0fd9b53so4037482b3a.1
        for <linux-block@vger.kernel.org>; Tue, 12 Dec 2023 17:02:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702429340; x=1703034140;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6AgxkDZe1sYPxHkKXBHiqEkCdxUVIAsai3q0sOwUAC8=;
        b=wBDqp2q0TWB8QqJwmCZAvTNExbiiccl+6dXG/ad85eXQ0d03GNxxufQjDzPysZj2R/
         wXPG4YhWPd+nKAW05Qg7eY0PYi6g043fQx5lZbtzim36Q0NbjE2YOaTXf6XCeq6UP2RA
         K5SZNxpCgHaIYz1QCMLddO7cLeks8HZcW8wLY3xoO1R4xSczp0fV3o3ggNHD069eByZh
         9OHzObjFOGQlzQBAHt8r3XK3Yit53HycR3rHdORrGNRe+xKgS2AObaP7dztLjAK3i62J
         /Eklh7XdKZu50LfhbaierIPWzAg+1HEQYf/VYhfTtJK72i3Y9gdt8OGYzyhhRqHVN6z/
         gi9A==
X-Gm-Message-State: AOJu0YwonPFOTFbouIZqygxQw999kGG/kqNzypK9oGm5wMe2y8kl6PV8
	dSnKkL3kfjVOFUTpxd4ZjX17x4deC1PG2w==
X-Google-Smtp-Source: AGHT+IHUA9mfiZxcItP3OIlCSLPILoXWdI5Dnpup9Im6GdYa3uRBvmj+HiuphZTMe5KMZ8ZcaNzF7Q==
X-Received: by 2002:a17:902:d2cd:b0:1d0:609e:f6dc with SMTP id n13-20020a170902d2cd00b001d0609ef6dcmr4644962plc.1.1702429339998;
        Tue, 12 Dec 2023 17:02:19 -0800 (PST)
Received: from [192.168.51.14] (c-73-231-117-72.hsd1.ca.comcast.net. [73.231.117.72])
        by smtp.gmail.com with ESMTPSA id w6-20020a170902d3c600b001d3491dcde4sm457964plb.223.2023.12.12.17.02.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Dec 2023 17:02:19 -0800 (PST)
Message-ID: <3248683c-d2af-4f0c-b665-1aeff41e9d21@acm.org>
Date: Tue, 12 Dec 2023 17:02:18 -0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] block/mq-deadline: Disable I/O prioritization in
 certain cases
Content-Language: en-US
To: Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 Jaegeuk Kim <jaegeuk@kernel.org>
References: <20231205053213.522772-1-bvanassche@acm.org>
 <20231205053213.522772-4-bvanassche@acm.org>
 <100ddd75-eef5-44e9-93ff-34e093b19ab7@kernel.org>
 <4d506909-e063-4918-a9d3-e91bfa5a41a3@acm.org>
 <37f3179a-9add-4ee6-9ae9-cf84c1584366@kernel.org>
 <e8d383c8-2274-4afa-9beb-a38c9f56127b@acm.org>
 <deee82e3-ccc4-42d7-bb54-9f4d1cd886b0@kernel.org>
 <8998e3cd-6bf1-4199-9e21-60fdfba37571@acm.org>
 <95ecba8c-9a1a-49c9-92c8-f45580bc9f95@kernel.org>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <95ecba8c-9a1a-49c9-92c8-f45580bc9f95@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/12/23 13:52, Damien Le Moal wrote:
> Trying to solve this issue in mq-deadline would require keeping track of the io
> priority used for a write request that is issued to a zone and use that same
> priority for all following write requests for the same zone until there are no
> writes pending for that zone. Otherwise, you will get the priority inversion
> causing the reordering.
> 
> But I think that doing all this without also causing priority inversion for the
> user, i.e. a high priority write request ends up waiting for a low priority one,
> will be challenging, to say the least.

Hi Damien,

How about the following algorithm?
- If a zoned write refers to the start of a zone or no other writes for
   the same zone occur in the RB-tree, use the I/O priority of the zoned
   write.
- If another write for the same zone occurs in the RB-tree, use the I/O
   priority from that other write.

While this algorithm does not guarantee that all zoned writes for a 
single zone have the same I/O priority, it guarantees that the 
mq-deadline I/O scheduler won't submit zoned writes in the wrong order 
because of their I/O priority.

Thanks,

Bart.

