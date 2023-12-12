Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20BBD99
	for <linux-block@vger.kernel.org>; Tue, 12 Dec 2023 09:15:51 -0800 (PST)
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1d2e6e14865so27673445ad.0
        for <linux-block@vger.kernel.org>; Tue, 12 Dec 2023 09:15:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702401350; x=1703006150;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NsrHnjXSM7KF2F+ya3FOD/Ax6L4eHqD7aeY1KRagvQE=;
        b=SZ2wQoOq28/VblFu+tUAmA4BULYRCUzVOp1ReiPmeL4hA7oPK4AfPi1UK2LauFnxCa
         C8d0EZjzKhZeyzMGVTM3mOMWfaDAtDACFnOdmRI9Ts/2A+z2vYZqdHUTCtNOH1kblzN2
         JmFCkFkk/fOe8bAGT+r93zFM+OsZ7rQY0c5HreLbCpWYGoBIVpLYQCJedGQRZh6vup6N
         goZ6Xb2y5i6l+tXAFXn4lhjV/u1rb+SqMt+9CJG5nmBnAJ1gkNnpf71gU/Mz3EN1fFOt
         1JUuC4W1pfRkQExWjI4q5H+Sk39IzJl+8HcibEY6ckOTgqznYIQCrkBFOE4M7fkNrHbE
         Pb7A==
X-Gm-Message-State: AOJu0YwUjKPY6ni7ts+4jd3bOThs/cLONkCdJlRph5AGukE6chOERMy9
	czmcB67l3k2DcBO86RH6yqc=
X-Google-Smtp-Source: AGHT+IFi6GiIiddfAmb/Ona6FbtisG+/WqNv/7oHv9ZqvBPNMUytJX4f5t/fzR1i8TjEU+P0gi8w2Q==
X-Received: by 2002:a17:902:e882:b0:1d0:a146:f859 with SMTP id w2-20020a170902e88200b001d0a146f859mr3994479plg.114.1702401350145;
        Tue, 12 Dec 2023 09:15:50 -0800 (PST)
Received: from ?IPV6:2620:0:1000:8411:4cb1:76fa:137e:ca8? ([2620:0:1000:8411:4cb1:76fa:137e:ca8])
        by smtp.gmail.com with ESMTPSA id p18-20020a170902ead200b001d053ec1992sm8880629pld.83.2023.12.12.09.15.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Dec 2023 09:15:49 -0800 (PST)
Message-ID: <42054848-2e8d-4856-b404-c042a4365097@acm.org>
Date: Tue, 12 Dec 2023 09:15:48 -0800
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
To: Christoph Hellwig <hch@lst.de>, Damien Le Moal <dlemoal@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 Jaegeuk Kim <jaegeuk@kernel.org>
References: <20231205053213.522772-1-bvanassche@acm.org>
 <20231205053213.522772-4-bvanassche@acm.org> <20231211165720.GC26039@lst.de>
 <177773fd-c8ed-4822-9344-3058e820ddf0@kernel.org>
 <20231212154140.GB20933@lst.de>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20231212154140.GB20933@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/12/23 07:41, Christoph Hellwig wrote:
> On Tue, Dec 12, 2023 at 07:40:02AM +0900, Damien Le Moal wrote:
>> The latter is I think better than the former as CGs can change without the FS
>> being aware (as far as I know), and such support would need to be implemented
>> for all FSes that support zone writing using regular writes (f2fs and zonefs).
> 
> How is cse 2 any kind of problem when using the proper append model?
> Except when blk-zoned delays it so much that we really need to close
> the zone becaue it's timing out, but that would really be configuration
> issue.

As mentioned before, UFS devices implement the SCSI command set and hence do not
support write append operations. If anyone else standardizes a write append
command for SCSI we can ask UFS vendors to implement that command. However, as
far as I know nobody in T10 is working on standardizing a write append command.

Bart.
