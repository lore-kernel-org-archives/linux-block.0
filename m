Return-Path: <SRS0=yWSg=4X=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A41D9C10F00
	for <linux-block@archiver.kernel.org>; Fri,  6 Mar 2020 09:25:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79B072070A
	for <linux-block@archiver.kernel.org>; Fri,  6 Mar 2020 09:25:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583486755;
	bh=hvYtDxfTdSO0IQqKG8VvKQf8ALSlcBw1u60NrHZfw3I=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=prHvDB2VdIku7/ApCdWoyRKFpMzwpgzGkKIJ/MwnrF+7Xvm/QM/Rf69KbOQ0ECoUV
	 XQRXWo9855HxCP+4i5qat8VKlZiaWfsGpp3p8IBfUxX2kNFD+j57Msq3mM2x8sDh58
	 WIPbPuW0rKMSV3iCnh1JjZ7793nVCqpJWE6mUIYs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725873AbgCFJZy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 6 Mar 2020 04:25:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:40288 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725923AbgCFJZy (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 6 Mar 2020 04:25:54 -0500
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8BB392070A
        for <linux-block@vger.kernel.org>; Fri,  6 Mar 2020 09:25:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583486752;
        bh=hvYtDxfTdSO0IQqKG8VvKQf8ALSlcBw1u60NrHZfw3I=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=c28pCLtRg8NNN6/aBw+kh86LkT3kNDSnBm73GPEyOkjimeyO62dVNbgRjtJqsSMC/
         8kXd7cKEJ8fJFtMLlMIdnxOozHP91eUqvE9eYB3e8hree15nSD8fVvq6zAA+BmGvSY
         TLD3wqMwCC4H7OpDu8+V3ktvGu1+Y/BsIguj2CJ4=
Received: by mail-wm1-f41.google.com with SMTP id e26so1547895wme.5
        for <linux-block@vger.kernel.org>; Fri, 06 Mar 2020 01:25:52 -0800 (PST)
X-Gm-Message-State: ANhLgQ1CJqG2X+lQxbKwLF6zX3BMX+98Wjd7iEtf6HeQKj9VMPNCkShj
        8X9N4BELqlpLHcWzne7R4lWRiaUs/baj0E5hP863Xw==
X-Google-Smtp-Source: ADFU+vsiyg11BS62UthU1DW47ddgMms6y8DgTIrlz1HDnwUZjnbKuVKNBjcLEX+qom4x416GqrFQoi0ZM1Q9AF44P2k=
X-Received: by 2002:a7b:cb93:: with SMTP id m19mr3131678wmi.133.1583486751063;
 Fri, 06 Mar 2020 01:25:51 -0800 (PST)
MIME-Version: 1.0
References: <20181124162123.21300-1-n.merinov@inango-systems.com>
 <20191224092119.4581-1-n.merinov@inango-systems.com> <20200108133926.GC4455@infradead.org>
 <26f7bd89f212f68b03a4b207e96d8702c9049015.1578910723.git.n.merinov@inango-systems.com>
 <20200218185336.GA14242@infradead.org> <797777312.1324734.1582544319435.JavaMail.zimbra@inango-systems.com>
 <20200224170813.GA27403@infradead.org> <711479725.2305.1583484191776.JavaMail.zimbra@inango-systems.com>
In-Reply-To: <711479725.2305.1583484191776.JavaMail.zimbra@inango-systems.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 6 Mar 2020 10:25:39 +0100
X-Gmail-Original-Message-ID: <CAKv+Gu8ufmONSU8SX=NaAZBAKuD4Coo19z6e2MJ7BegsseJ63A@mail.gmail.com>
Message-ID: <CAKv+Gu8ufmONSU8SX=NaAZBAKuD4Coo19z6e2MJ7BegsseJ63A@mail.gmail.com>
Subject: Re: [PATCH v3] partitions/efi: Fix partition name parsing in GUID
 partition entry
To:     Nikolai Merinov <n.merinov@inango-systems.com>
Cc:     hch <hch@infradead.org>, Davidlohr Bueso <dave@stgolabs.net>,
        Jens Axboe <axboe@kernel.dk>,
        linux-efi <linux-efi@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, 6 Mar 2020 at 09:43, Nikolai Merinov
<n.merinov@inango-systems.com> wrote:
>
> Hi Christoph,
>
> Should I perform any other steps in order to get this change in the master?
>

I can take it via the EFI tree with an ack from Dave.


>
> ----- Original Message -----
> > From: "hch" <hch@infradead.org>
> > To: "n merinov" <n.merinov@inango-systems.com>
> > Cc: "hch" <hch@infradead.org>, "Davidlohr Bueso" <dave@stgolabs.net>, "Jens Axboe" <axboe@kernel.dk>, "Ard Biesheuvel"
> > <ardb@kernel.org>, "linux-efi" <linux-efi@vger.kernel.org>, "linux-block" <linux-block@vger.kernel.org>, "linux-kernel"
> > <linux-kernel@vger.kernel.org>
> > Sent: Monday, February 24, 2020 10:08:13 PM
> > Subject: Re: [PATCH v3] partitions/efi: Fix partition name parsing in GUID partition entry
>
> > On Mon, Feb 24, 2020 at 01:38:39PM +0200, Nikolai Merinov wrote:
> >> Hi Christoph,
> >>
> >> > I'd rather use plain __le16 and le16_to_cpu here. Also the be
> >> > variants seems to be entirely unused.
> >>
> >> Looks like I misunderstood your comment from
> >> https://patchwork.kernel.org/patch/11309223/:
> >>
> >> > Please add a an efi_char_from_cpu or similarly named helper
> >> > to encapsulate this logic.
> >>
> >> The "le16_to_cpu(ptes[i].partition_name[label_count])" call is the
> >> full implementation of the "efi_char_from_cpu" logic. Do you want
> >> to encapsulate "utf16_le_to_7bit_string" logic entirely like in
> >> the attached version?
> >
> > I think I though of just the inner loop, but your new version looks even
> > better, so:
> >
> > Reviewed-by: Christoph Hellwig <hch@lst.de>
