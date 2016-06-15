Return-Path: <sagigrim@gmail.com>
Return-Path: <sagigrim@gmail.com>
Subject: Re: [PATCH 6/8] nvme-fabrics: add a generic NVMe over Fabrics library
To: Keith Busch <keith.busch@intel.com>, Christoph Hellwig <hch@lst.de>
References: <1465829128-22993-1-git-send-email-hch@lst.de>
 <1465829128-22993-7-git-send-email-hch@lst.de>
 <20160615191603.GC1919@localhost.localdomain>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-rdma@vger.kernel.org,
 Armen Baloyan <armenx.baloyan@intel.com>,
 Jay Freyensee <james.p.freyensee@intel.com>,
 Ming Lin <ming.l@ssi.samsung.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <5761A983.6020807@grimberg.me>
Date: Wed, 15 Jun 2016 22:16:19 +0300
MIME-Version: 1.0
In-Reply-To: <20160615191603.GC1919@localhost.localdomain>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-block@vger.kernel.org>


>> @@ -107,10 +108,19 @@ struct nvme_ctrl {
>>   	u8 event_limit;
>>   	u8 vwc;
>>   	u32 vs;
>> +	u32 sgls;
>>   	bool subsystem;
>>   	unsigned long quirks;
>>   	struct work_struct scan_work;
>>   	struct work_struct async_event_work;
>> +
>> +	/* Fabrics only */
>> +	u16 sqsize;
>> +	u32 ioccsz;
>> +	u32 iorcsz;
>> +	u16 icdoff;
>> +	u16 maxcmd;
>> +	struct nvmf_ctrl_options *opts;
>>   };
>
> The pci only stuff goes in 'struct nvme_dev' and embeds 'struct
> nvme_ctrl', but fabrics gets to use nvme_ctrl directly?
>
> If we need transport specifics for anything, like you have during
> nvme_init_identify, I think we should add function callbacks to
> nvme_ctrl_ops to set up those specifics, then we don't need 'is_fabrics'
> checks.

That's where we started off from :)

But we got to a point where it started getting convoluted for generic
nvme optional features which are mandatory for fabrics (like keep-alive
support) that are detected in different forms (controller identify and
fabric admin connect). Anyway we thought it'd be cleaner to have it
directly in nvme_ctrl and centralize their assignments in a single
location.
