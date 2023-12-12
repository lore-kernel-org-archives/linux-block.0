Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5197691
	for <linux-block@vger.kernel.org>; Tue, 12 Dec 2023 09:42:27 -0800 (PST)
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-7b6fa79b547so351115139f.1
        for <linux-block@vger.kernel.org>; Tue, 12 Dec 2023 09:42:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702402946; x=1703007746;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q+gS8FgjYGOJzlLiWHZHMdMu5WYv6GcbSYGpOAsbDgQ=;
        b=IQnRWyCZTAsYeVUvsQprqxS9RLVx3UKF6TqrmsP6HPwYcPW1GKK51c3S78EJO9RXoZ
         kn22VBMtLflS7aiUdf/5sbSbLUSXUywn47is3DdqzPXChRY0tHfHOKI0Z+r6oCFNN0SQ
         DZZTVTu70PbX2S69Jv/HxuNpR30ahRGj2+hwZyG13WPeDrKsu9ZQqSNo6iM5UZgJi9NG
         0uty/wrCUQTLVDfLNY/PYy9qAxrWBqtBbkq686WHLA9+0P4ynwWuWi+BlMiEA3J/jrzn
         jOiVd+SzIWYIbBWKMLyTkIL+0EpkmBmkvzJq9jdG4ni9Y1YocbYK+GPu0pj7c2zJEzX6
         EKOg==
X-Gm-Message-State: AOJu0YxFAVDomRAaN6Dp1XQdONpBvXG8GRYX0m1DRdKTHTT3EtRXPmUF
	wHSN8gxd0IOMxff10VBqKDNYqyvmRmw=
X-Google-Smtp-Source: AGHT+IEUyoS/7vmpF0Hb4UQcmc0fZm2hx7IOpI48M2beeRDp/xLAOeezXLNEmtWWS0kjCVWOv/5m5Q==
X-Received: by 2002:a05:6e02:178a:b0:35d:6caf:78c4 with SMTP id y10-20020a056e02178a00b0035d6caf78c4mr9562243ilu.80.1702402946452;
        Tue, 12 Dec 2023 09:42:26 -0800 (PST)
Received: from ?IPV6:2620:0:1000:8411:4cb1:76fa:137e:ca8? ([2620:0:1000:8411:4cb1:76fa:137e:ca8])
        by smtp.gmail.com with ESMTPSA id b32-20020a630c20000000b0059d34fb9ccasm8397938pgl.2.2023.12.12.09.42.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Dec 2023 09:42:26 -0800 (PST)
Message-ID: <686cc853-96e2-4aa4-8f68-fdcc5cdabbba@acm.org>
Date: Tue, 12 Dec 2023 09:42:24 -0800
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
To: Christoph Hellwig <hch@lst.de>
Cc: Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>
References: <20231205053213.522772-1-bvanassche@acm.org>
 <20231205053213.522772-4-bvanassche@acm.org> <20231211165720.GC26039@lst.de>
 <177773fd-c8ed-4822-9344-3058e820ddf0@kernel.org>
 <20231212154140.GB20933@lst.de>
 <42054848-2e8d-4856-b404-c042a4365097@acm.org>
 <20231212171846.GA28682@lst.de>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20231212171846.GA28682@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/12/23 09:18, Christoph Hellwig wrote:
> On Tue, Dec 12, 2023 at 09:15:48AM -0800, Bart Van Assche wrote:
>> As mentioned before, UFS devices implement the SCSI command set and hence do not
>> support write append operations. If anyone else standardizes a write append
>> command for SCSI we can ask UFS vendors to implement that command. However, as
>> far as I know nobody in T10 is working on standardizing a write append command.
> 
> The actual hardware support does not matter, it's the programming model.
> Even with the zone append emulation in sd you don't need to care about
> reordering due to I/O priorities.

The actual hardware support does matter. Using the zone append emulation from
drivers/scsi/sd_zbc.c (or any other zone append emulation) is not an option for
high performance devices. This is because emulating zone append can only be done
by serializing write operations. Any such serialization negatively affects
performance.

Thanks,

Bart.
