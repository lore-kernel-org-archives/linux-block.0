Return-Path: <sagigrim@gmail.com>
Return-Path: <sagigrim@gmail.com>
Subject: Re: [PATCH 2/5] nvme: register ns_id attributes as default sysfs
 groups
To: Bart Van Assche <Bart.VanAssche@wdc.com>, "hch@lst.de" <hch@lst.de>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "hare@suse.de" <hare@suse.de>, "axboe@kernel.dk" <axboe@kernel.dk>,
 "hare@suse.com" <hare@suse.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "keith.busch@intel.com" <keith.busch@intel.com>
References: <20180814073305.87255-1-hare@suse.de>
 <20180814073305.87255-3-hare@suse.de>
 <5a4aab8b5f509d8090ad10107b01d11285fe1528.camel@wdc.com>
 <e4c9ba55-ad92-dcb2-1126-38e5ea4c0a13@suse.de>
 <f9ad4ed4685e51a7b0378f11d3ce9d0a76235095.camel@wdc.com>
 <20180817070013.GD11170@lst.de>
 <e3861d6482bef5595720c4e296a1c0e864226323.camel@wdc.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <23e2d972-c1fd-4581-60d1-a3a736f311a8@grimberg.me>
Date: Fri, 17 Aug 2018 15:47:04 -0700
MIME-Version: 1.0
In-Reply-To: <e3861d6482bef5595720c4e296a1c0e864226323.camel@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
List-ID: <linux-block@vger.kernel.org>


> Hello Christoph,
> 
> How about applying the patch below on top of Hannes' patch? The patch below
> has the advantage that it completely separates the open channel sysfs
> attributes from the NVMe core sysfs attributes - the open channel code
> doesn't have to know anything about the NVMe core sysfs attributes and the
> NVMe core does not have to know anything about the open channel sysfs
> attributes.

This looks better to me Bart (unless I'm missing something)
