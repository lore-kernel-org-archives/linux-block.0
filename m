Return-Path: <jthumshirn@suse.de>
Subject: Re: WARN_ON() when booting with nvme loopback over zram
To: Jens Axboe <axboe@kernel.dk>,
 Linux Block Layer Mailinglist <linux-block@vger.kernel.org>,
 Linux NVMe Mailinglist <linux-nvme@lists.infradead.org>
References: <20170303161826.GA26324@linux-x5ow.site>
 <d18616eb-bce4-379b-4328-f4df4763a10a@kernel.dk>
From: Johannes Thumshirn <jthumshirn@suse.de>
Message-ID: <b7d20007-6174-cf31-f9aa-7ca2237023fb@suse.de>
Date: Mon, 6 Mar 2017 09:35:04 +0100
MIME-Version: 1.0
In-Reply-To: <d18616eb-bce4-379b-4328-f4df4763a10a@kernel.dk>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-block@vger.kernel.org>

On 03/03/2017 05:20 PM, Jens Axboe wrote:
> On 03/03/2017 09:18 AM, Johannes Thumshirn wrote:
>> Hi,
>>
>> I get the following WARN_ON when trying to establish a nvmf loopback device
>> backed by zram.
>>
>> My topmost commit is c82be9d2244aacea9851c86f4fb74694c99cd874
> 
> It's fixed in my for-linus, pull request went out to Linus yesterday.
> So hopefully master should be fine with nvmf very shortly.
> 

Yup today's pull fixed it.

Thanks,
	Johannes

-- 
Johannes Thumshirn                                          Storage
jthumshirn@suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N�rnberg
GF: Felix Imend�rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N�rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
