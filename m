Return-Path: <axboe@kernel.dk>
Subject: Re: WARN_ON() when booting with nvme loopback over zram
To: Johannes Thumshirn <jthumshirn@suse.de>,
 Linux Block Layer Mailinglist <linux-block@vger.kernel.org>,
 Linux NVMe Mailinglist <linux-nvme@lists.infradead.org>
References: <20170303161826.GA26324@linux-x5ow.site>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <d18616eb-bce4-379b-4328-f4df4763a10a@kernel.dk>
Date: Fri, 3 Mar 2017 09:20:19 -0700
MIME-Version: 1.0
In-Reply-To: <20170303161826.GA26324@linux-x5ow.site>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-block@vger.kernel.org>

On 03/03/2017 09:18 AM, Johannes Thumshirn wrote:
> Hi,
> 
> I get the following WARN_ON when trying to establish a nvmf loopback device
> backed by zram.
> 
> My topmost commit is c82be9d2244aacea9851c86f4fb74694c99cd874

It's fixed in my for-linus, pull request went out to Linus yesterday.
So hopefully master should be fine with nvmf very shortly.

-- 
Jens Axboe
