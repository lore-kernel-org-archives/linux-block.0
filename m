Return-Path: <prvs=708eb8c04=bart.vanassche@wdc.com>
Subject: Re: [PATCH] blk-mq: use mutex_trylock to avoid lock inversion
To: "jianchao.wang" <jianchao.w.wang@oracle.com>,
 "axboe@kernel.dk" <axboe@kernel.dk>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <1529391637-1704-1-git-send-email-jianchao.w.wang@oracle.com>
 <2409013d789ca266879d24c815b76c2193e23fe3.camel@wdc.com>
 <d528a730-8e44-225b-2a35-3544160761dc@oracle.com>
 <2c2003ff1baac05688495677f67239d52f6d9527.camel@wdc.com>
 <2a1dda06-5c7c-b75b-c1ae-75d1a2a49694@oracle.com>
 <a0350d07-3c11-c04c-d9ba-94a5868e7d8f@oracle.com>
From: Bart Van Assche <bart.vanassche@wdc.com>
Message-ID: <1d4d1dc3-7014-4e2a-1ea5-e1446381b404@wdc.com>
Date: Tue, 26 Jun 2018 08:36:53 -0700
MIME-Version: 1.0
In-Reply-To: <a0350d07-3c11-c04c-d9ba-94a5868e7d8f@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-block@vger.kernel.org>

On 06/25/18 20:47, jianchao.wang wrote:
> V2 patch has been posted, would you please take a look at on them ?
> https://marc.info/?l=linux-block&m=152965143412927&w=2

Hello Jianchao,

Patches 1/3 and 2/3 of that series look fine to me but I don't like the 
approach of patch 3/3 so please do not expect a review from me for that 
patch.

Thanks,

Bart.
