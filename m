Return-Path: <SRS0=vmzB=QS=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6325C282CE
	for <linux-block@archiver.kernel.org>; Mon, 11 Feb 2019 17:28:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 811602229E
	for <linux-block@archiver.kernel.org>; Mon, 11 Feb 2019 17:28:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728310AbfBKR2f (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 11 Feb 2019 12:28:35 -0500
Received: from smtp3-g21.free.fr ([212.27.42.3]:30214 "EHLO smtp3-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726140AbfBKR2f (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 11 Feb 2019 12:28:35 -0500
Received: from [192.168.108.68] (unknown [213.36.7.13])
        (Authenticated sender: marc.w.gonzalez)
        by smtp3-g21.free.fr (Postfix) with ESMTPSA id D39E613F81D;
        Mon, 11 Feb 2019 18:27:41 +0100 (CET)
Subject: Re: dd hangs when reading large partitions
From:   Marc Gonzalez <marc.w.gonzalez@free.fr>
To:     Bart Van Assche <bvanassche@acm.org>,
        linux-mm <linux-mm@kvack.org>,
        linux-block <linux-block@vger.kernel.org>
Cc:     Jianchao Wang <jianchao.w.wang@oracle.com>,
        Christoph Hellwig <hch@infradead.org>,
        Jens Axboe <axboe@kernel.dk>,
        fsdevel <linux-fsdevel@vger.kernel.org>,
        SCSI <linux-scsi@vger.kernel.org>,
        Jeffrey Hugo <jhugo@codeaurora.org>,
        Evan Green <evgreen@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Tomas Winkler <tomas.winkler@intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        Martin Petersen <martin.petersen@oracle.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ming Lei <ming.lei@redhat.com>, Omar Sandoval <osandov@fb.com>,
        Roman Gushchin <guro@fb.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        James Bottomley <jejb@linux.ibm.com>
References: <f792574c-e083-b218-13b4-c89be6566015@free.fr>
 <398a6e83-d482-6e72-5806-6d5bbe8bfdd9@oracle.com>
 <ef734b94-e72b-771f-350b-08d8054a58f3@kernel.dk>
 <20190119095601.GA7440@infradead.org>
 <07b2df5d-e1fe-9523-7c11-f3058a966f8a@free.fr>
 <985b340c-623f-6df2-66bd-d9f4003189ea@free.fr>
 <b3910158-83d6-21fe-1606-33e88912404a@oracle.com>
 <d082bdee-62e5-d470-b63b-196c0fe3b9fb@free.fr>
 <5132e41b-cb1a-5b81-4a72-37d0f9ea4bb9@oracle.com>
 <7bd8b010-bf0c-ad64-f927-2d2187a18d0b@free.fr>
 <0cfe1ed2-41e1-66a4-8d98-ebc0d9645d21@free.fr>
 <d91e8342-4672-d51d-1bde-74e910e5a959@free.fr>
 <27165898-88c3-ab42-c6c9-dd52bf0a41c8@free.fr>
 <66419195-594c-aa83-c19d-f091ad3b296d@free.fr>
 <1549640986.34241.78.camel@acm.org>
 <690af800-1cd2-3e68-94d9-bc4825790837@free.fr>
Message-ID: <493e04e4-849d-8f25-95e3-408f775fab64@free.fr>
Date:   Mon, 11 Feb 2019 18:27:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <690af800-1cd2-3e68-94d9-bc4825790837@free.fr>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/02/2019 17:36, Marc Gonzalez wrote:

> On 08/02/2019 16:49, Bart Van Assche wrote:
> 
>> Does this problem only occur with block devices backed by the UFS driver
>> or does this problem also occur with other block drivers?
> 
> Yes, same issue with a USB3 mass storage device:
> 
> usb 2-1: new SuperSpeed Gen 1 USB device number 2 using xhci-hcd
> usb 2-1: New USB device found, idVendor=05dc, idProduct=a838, bcdDevice=11.00
> usb 2-1: New USB device strings: Mfr=1, Product=2, SerialNumber=3
> usb 2-1: Product: USB Flash Drive
> usb 2-1: Manufacturer: Lexar
> usb 2-1: SerialNumber: AAYW2W7I13BAR0JC
> usb-storage 2-1:1.0: USB Mass Storage device detected
> scsi host0: usb-storage 2-1:1.0
> scsi 0:0:0:0: Direct-Access     Lexar    USB Flash Drive  1100 PQ: 0 ANSI: 6
> sd 0:0:0:0: [sda] 62517248 512-byte logical blocks: (32.0 GB/29.8 GiB)
> sd 0:0:0:0: [sda] Write Protect is off
> sd 0:0:0:0: [sda] Mode Sense: 43 00 00 00
> sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
>  sda: sda1
> sd 0:0:0:0: [sda] Attached SCSI removable disk
> 
> # dd if=/dev/sda of=/dev/null bs=1M status=progress
> 3879731200 bytes (3.9 GB, 3.6 GiB) copied, 56.0097 s, 69.3 MB/s
> 
> So the problem could be in SCSI glue, or block, or mm?

Unlikely. Someone else would have been affected...

A colleague pointed out that some memory areas are reserved downstream.
Perhaps the FW goes haywire once the kernel touches reserved memory?

I'm off to test that hypothesis.

Regards.
