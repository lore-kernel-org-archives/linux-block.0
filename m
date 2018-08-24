Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-it0-f68.google.com ([209.85.214.68]:40064 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726504AbeHXVOP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 24 Aug 2018 17:14:15 -0400
Received: by mail-it0-f68.google.com with SMTP id h23-v6so2910228ita.5
        for <linux-block@vger.kernel.org>; Fri, 24 Aug 2018 10:38:38 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <yq1a7pb9196.fsf@oracle.com>
References: <1533928331-21303-1-git-send-email-jeff.lien@wdc.com>
 <yq1in4gq5jf.fsf@oracle.com> <yq1lg8zb2lp.fsf@oracle.com> <20180822062016.GA10356@infradead.org>
 <SN1PR04MB18241CBDC8E4CA5275EE4424EA360@SN1PR04MB1824.namprd04.prod.outlook.com>
 <CAKv+Gu-RwCrdgW69NVpyRLwGPGPCZx+ksTBM7NZk7v0-dzczGg@mail.gmail.com> <yq1a7pb9196.fsf@oracle.com>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Fri, 24 Aug 2018 18:38:36 +0100
Message-ID: <CAKv+Gu8Y7YmyB5rmxaj-SGB7q03in7ijv2cOifwYnhP5CNastw@mail.gmail.com>
Subject: Re: [PATCH] Performance Improvement in CRC16 Calculations.
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Jeffrey Lien <Jeff.Lien@wdc.com>,
        Christoph Hellwig <hch@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        "tim.c.chen@linux.intel.com" <tim.c.chen@linux.intel.com>,
        David Darrington <david.darrington@wdc.com>,
        Jeff Furlong <jeff.furlong@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 24 August 2018 at 17:29, Martin K. Petersen
<martin.petersen@oracle.com> wrote:
>
> Ard,
>
>> Would it be possible to allocate the crypto transform upon first use
>> instead of from an initcall? If crc_t10dif() is mostly called from
>> non-process context, that would not really work, but otherwise, we
>> could simply defer it (and occasional calls from non-process context
>> that do occur would use the generic code until the point where another
>> call from process context allocates the transform)
>
> The function is always called from user context. However, postponing the
> crypto transform registration doesn't solve the common scenario of the
> user booting off of a Fibre Channel/SAS/NVMe device with the desired
> crct10dif-pclmul.ko module located on the boot drive.
>
> If there is no good way to teach crypto to update existing registrations
> when a higher priority transformation becomes available, then we
> probably need to explore tweaking dracut to unconditionally load
> crct10dif-pclmul (and your ARM equivalent). Looks like there are already
> hacks in place in dracut to preload crc32c for btrfs and XFS.
>

I'd prefer to handle this without help from userland.

It shouldn't be too difficult to register a module notifier that only
sets a flag (or the static key, even?), and to free and re-allocate
the crc_t10dif transform if the flag is set.


> Anyway. Just seems like the kernel is violating the principle of least
> surprise here. The kernel should always pick the best available tool for
> the job...
>
> --
> Martin K. Petersen      Oracle Linux Engineering
