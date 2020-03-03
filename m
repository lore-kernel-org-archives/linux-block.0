Return-Path: <SRS0=QBb8=4U=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D864BC3F2CD
	for <linux-block@archiver.kernel.org>; Tue,  3 Mar 2020 14:49:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA54220838
	for <linux-block@archiver.kernel.org>; Tue,  3 Mar 2020 14:49:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZPGoMhDg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729633AbgCCOta (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 3 Mar 2020 09:49:30 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:34212 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729572AbgCCOt3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 3 Mar 2020 09:49:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583246969;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZAMz9trEBbggImBzI8TwjqrfBpm7beP6aWAuQ0+PcZA=;
        b=ZPGoMhDg8GOXz6SKNnzZmOJ5cPWrhyRoDnmBE8rDNa5gM6jptzUCIKjlAPgMF/SN2TZ5vX
        0M5thhMSvaiPAYtLDU2UU0yZ5721nG9obZBjdnScImUl3PSNuHF/R5KQcWi/hoeR6Ixs52
        QwB9IE/SKcyNvd/K9c/AMmIu7hUsi9k=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-168-i58ipQ9qODSWrEiQQOuHZA-1; Tue, 03 Mar 2020 09:49:27 -0500
X-MC-Unique: i58ipQ9qODSWrEiQQOuHZA-1
Received: by mail-qv1-f72.google.com with SMTP id o18so2198315qvk.9
        for <linux-block@vger.kernel.org>; Tue, 03 Mar 2020 06:49:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZAMz9trEBbggImBzI8TwjqrfBpm7beP6aWAuQ0+PcZA=;
        b=fqrVDKzi5rTfR0XOnAPYfWEE+xBL/bLctE2fgQ3E/jse7K+pjvEid6nAaZSqOnNWln
         SnaMItfpDB/o0JXb9nRObAeRKMADBFBdqu4rPdwARL1cFm6Hg8kMCkjstnMEUvfvOt4Y
         iOJM/AGllOFhTnRYpttVl/AoSR2yI7HFYom6FkAQa7Mph/MNcNnbEjhWahUMxDzW8CDW
         slCxI1uOYRC3MiQW0qx8ZgUSHfXB3rlDVdFhbJKOiZDdEsVmUXwNFQicyWdN7xJXO5qq
         6SYUliLtq1ypbxT6RfaCGHuuW+TGdonn7Jc6/sqpE+GD44VFYuhTrgBclJENCui+4cLX
         Xl5g==
X-Gm-Message-State: ANhLgQ3g2tHQ6wpxyJsii+4voRCM3yLnjcFHhQ9GqZYnx/T8Fm+5hV5Y
        iiL+i/hmjOSKiI669iR+wm9oxCaXJXpZwYbgLuCy1WTli7nd8Uyd6nbwlqmI2Yeua11E9n73oXt
        GiD7B399/QU290mB438kLijo=
X-Received: by 2002:a0c:f692:: with SMTP id p18mr4372494qvn.61.1583246967038;
        Tue, 03 Mar 2020 06:49:27 -0800 (PST)
X-Google-Smtp-Source: ADFU+vsyjBrEg2YMLlS4Ny5GGY4zKEspwxCc/KeO/4ULBZu3vu5BQGOxB/vGW3jXL4KM69SWf9Bpkw==
X-Received: by 2002:a0c:f692:: with SMTP id p18mr4372474qvn.61.1583246966856;
        Tue, 03 Mar 2020 06:49:26 -0800 (PST)
Received: from redhat.com (bzq-79-180-48-224.red.bezeqint.net. [79.180.48.224])
        by smtp.gmail.com with ESMTPSA id g8sm3079010qke.1.2020.03.03.06.49.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2020 06:49:26 -0800 (PST)
Date:   Tue, 3 Mar 2020 09:49:21 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Halil Pasic <pasic@linux.ibm.com>
Cc:     Jason Wang <jasowang@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Jens Axboe <axboe@kernel.dk>,
        virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Viktor Mihajlovski <mihajlov@linux.ibm.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Ram Pai <linuxram@us.ibm.com>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        "Lendacky, Thomas" <Thomas.Lendacky@amd.com>
Subject: Re: [PATCH 0/2] virtio-blk: improve handling of DMA mapping failures
Message-ID: <20200303094909-mutt-send-email-mst@kernel.org>
References: <20200213123728.61216-1-pasic@linux.ibm.com>
 <20200303151252.59d45e86.pasic@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200303151252.59d45e86.pasic@linux.ibm.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Mar 03, 2020 at 03:12:52PM +0100, Halil Pasic wrote:
> On Thu, 13 Feb 2020 13:37:26 +0100
> Halil Pasic <pasic@linux.ibm.com> wrote:
> 
> > Two patches are handling new edge cases introduced by doing DMA mappings
> > (which can fail) in virtio core.
> > 
> > I stumbled upon this while stress testing I/O for Protected Virtual
> > Machines. I deliberately chose a tiny swiotlb size and have generated
> > load with fio. With more than one virtio-blk disk in use I experienced
> > hangs.
> > 
> > The goal of this series is to fix those hangs.
> > 
> > Halil Pasic (2):
> >   virtio-blk: fix hw_queue stopped on arbitrary error
> >   virtio-blk: improve virtqueue error to BLK_STS
> > 
> >  drivers/block/virtio_blk.c | 17 ++++++++++++-----
> >  1 file changed, 12 insertions(+), 5 deletions(-)
> > 
> > 
> > base-commit: 39bed42de2e7d74686a2d5a45638d6a5d7e7d473
> 
> ping
> 
> Hi Michael, hi Jason,
> 
> I got some favorable reviews for this, but AFAIK I got nothing form the
> maintainers yet.
> 
> Is some of you going to pick these?
> 
> Regards,
> Halil

I've queued this, thanks!

