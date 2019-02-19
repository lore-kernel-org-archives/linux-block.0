Return-Path: <SRS0=aQmj=Q2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32714C43381
	for <linux-block@archiver.kernel.org>; Tue, 19 Feb 2019 01:37:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6F172173C
	for <linux-block@archiver.kernel.org>; Tue, 19 Feb 2019 01:37:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dy6gKJQb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732813AbfBSBhJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 18 Feb 2019 20:37:09 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:53937 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732614AbfBSBhJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Feb 2019 20:37:09 -0500
Received: by mail-wm1-f68.google.com with SMTP id e74so325847wmg.3;
        Mon, 18 Feb 2019 17:37:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=E7aDWG0NWgAmsbi+t+B9OHfHgVt+EmCyXgUpXwE4Bls=;
        b=Dy6gKJQb8/xRJQalUfcKU8roNbKkFzddhahDTe+DIC+ual85PEP4zXCPEzYly5MfTa
         Am/D+A/fpVrCYP92ZdjHg+rAROT3J7dTLAI/gmc9pJ41elD1xJQ3PINkiR2ieIumbg25
         fhCOfD2FQsrYaB4jxYWLien4ZK/b0CDMj7blXPzwdTYdjNyqUuScWiZKbigXCTnTRJ9L
         L2oA/7CoFMlFMZKOal3LS+6Y3L0xBz8RQVNXl0N5mRGRYEYohN1Cy3/HMA0XBvzNug9T
         qDW/ugfjKqLWk+nQ3W2u1TWxX33SBkSZ5FtGcWG8YmnLEE55xa+Mor6YT22h0tQgoAld
         3E7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E7aDWG0NWgAmsbi+t+B9OHfHgVt+EmCyXgUpXwE4Bls=;
        b=SLeI/y3i0s0WvCzmrfpF8UyQCdW3zFRnlh320ypVMRjZ/nhbc+aJpxE7cPipdYssbI
         vkPP2kI9xUoUFGfdudhhSSxWLOv0J92YtoF0QO6f6gYGloDonrAZ8wHOC/HmrPVhPp+3
         1v3zGQNv5E94U+FT4XXWYFk2nru1HCXxiujQ+dF6D3myITAAvnWcxyay0c3sRo3GEEs9
         biPosRvd7C2czcY0AaaVQoGclNyReLx1wBjz55FB1+nxNIPZvPTQJCxJvf2Gpp+X6npI
         8xSEZXmP+kIydOYNnNW3Hi+hUpbqFCkUCUfPvzzWLr9E4Bj9IYd6GJhbk5kQdLroqgt+
         bMag==
X-Gm-Message-State: AHQUAubNe82GFEotU/CqHIVIO4fSCyYUUEozXroCOnCaO2abiTah9/EP
        p8YXktvtdoPRPJCeKAoUlK73bju6xlFLraSVVK4=
X-Google-Smtp-Source: AHgI3IZx5mQVsnn5iioZAOeaddnABj05dAK9Aj/CY1UM1n/HSX3QWgF0HYaXfr6vj/1Mqo3oVVnXK7qWY7s7LHL4afQ=
X-Received: by 2002:a1c:ed0b:: with SMTP id l11mr871340wmh.43.1550540226698;
 Mon, 18 Feb 2019 17:37:06 -0800 (PST)
MIME-Version: 1.0
References: <yq1d0nxuf73.fsf@oracle.com> <20190213025717.20057-1-martin.petersen@oracle.com>
In-Reply-To: <20190213025717.20057-1-martin.petersen@oracle.com>
From:   Ming Lei <tom.leiming@gmail.com>
Date:   Tue, 19 Feb 2019 09:36:54 +0800
Message-ID: <CACVXFVN9LXodRP8+T_Vd8+5g9K=+hke7ik7N21=heb3csFhh=w@mail.gmail.com>
Subject: Re: [PATCH v2] scsi: sd: block: Fix regressions in read-only block
 device handling
To:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Linux SCSI List <linux-scsi@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        Jeremy Cline <jeremy@jcline.org>,
        Oleksii Kurochko <olkuroch@cisco.com>,
        stable <stable@vger.kernel.org>,
        linux-usb <linux-usb@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Feb 13, 2019 at 5:01 PM Martin K. Petersen
<martin.petersen@oracle.com> wrote:
>
> Some devices come online in write protected state and switch to
> read-write once they are ready to process I/O requests. These devices
> broke with commit 20bd1d026aac ("scsi: sd: Keep disk read-only when
> re-reading partition") because we had no way to distinguish between a
> user decision to set a block_device read-only and the actual hardware
> device being write-protected.
>
> Because partitions are dropped and recreated on revalidate we are
> unable to persist any user-provided policy in hd_struct. Introduce a
> bitmap in struct gendisk to track the user configuration. This bitmap
> is updated when BLKROSET is called on a given disk or partition.
>
> A helper function, get_user_ro(), is provided to determine whether the
> ioctl has forced read-only state for a given block device. This helper
> is used by set_disk_ro() and add_partition() to ensure that both
> existing and newly created partitions will get the correct state.

Hi Martin & Oleksii,

From the Bugzilla, looks it is only reported on the "Kingston DT Ultimate G3"
USB flash drive.

If it is true, this particular issue might be addressed simply by applying one
quirk on this drive, such as, by adding one delay before calling
sd_spinup_disk()
in the 1st sd_revalidate_disk() to wait until it is ready to process
I/O requests.

Otherwise if there are many such devices, I think your approach is good.

Thanks,
Ming Lei
