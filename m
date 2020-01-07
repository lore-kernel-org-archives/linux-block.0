Return-Path: <SRS0=BJAb=24=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C96D0C33C8C
	for <linux-block@archiver.kernel.org>; Tue,  7 Jan 2020 14:40:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E4072146E
	for <linux-block@archiver.kernel.org>; Tue,  7 Jan 2020 14:40:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cloud.ionos.com header.i=@cloud.ionos.com header.b="ePpI9i4E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727559AbgAGOk6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 7 Jan 2020 09:40:58 -0500
Received: from mail-il1-f196.google.com ([209.85.166.196]:37069 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727894AbgAGOk5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 7 Jan 2020 09:40:57 -0500
Received: by mail-il1-f196.google.com with SMTP id t8so45904471iln.4
        for <linux-block@vger.kernel.org>; Tue, 07 Jan 2020 06:40:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=psKIv5YXGmKAgyjaeMizGcajOmm44u8MIetgyrq+BDc=;
        b=ePpI9i4EOMN0a7BCeoLA7yDM3URjW0iAgbDyXBx3G2AolnnhWvXcK6ins8bx7nTmIB
         BRs9iCZe9a/9ATwdF2gMbnFoarUfZrd+y5YxXMndwHo3VvSBFITjYLMfG/rDaQG2QiCs
         oFPBY53+clp/r1Ld0ynOqGDtzIquoceVbBabpszuICqec1JsP3DXZqhQ4L7YRwwnJ+Hf
         0naN2RxeUY76+BlzyWzjAjePz9IKmuuSK6vFpwK04xRSlxK0DNDQKgJU3Gepc6OtrTYg
         oxyZGnh8igqX4piZXPaScFdoiA1386roAocpXXAh6mm7vDuCJxfHadFqUDKB/2Ia5G+C
         bUQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=psKIv5YXGmKAgyjaeMizGcajOmm44u8MIetgyrq+BDc=;
        b=tTXvrvKz34qLTCkxlSM/xN1vnmzK/rtI09WdtoeZ5Buv8YvGUYQRYIlfcNOIEyvfH/
         d9a4Rgs/9zhVjXpUiQvksc5NsPnYRvhGGmZLe8TLNF28DLHPwoy21udVNDRwcYP7scR/
         TQJpNT74WnqDB8F1ufl77PBU+yWr6ZXmbfBfMyAYbQPaksO5TXuvZBqOZtSP7hFjzp/O
         tpYDK7q1NU1SswusN0ITWywjJxEikz9MJ/HJeWEMHIUsr1eIcHcJf3aYGs+FIXDbIP0d
         TR/N6evaiJSR/Zvbfy3Y16P1Mf0yd18u1oANT+3WutP9ELLOESgVJ+9mC/7avL0E3gEF
         rObw==
X-Gm-Message-State: APjAAAWtzDhWjuzELpM8XoT8DWz+MRYqvcn3Hgd0rXw/HpT89faD9Ue0
        KNJw16CBT9/iY0UKSWIFlETyY2pgTB6aRLOz7JgwrA==
X-Google-Smtp-Source: APXvYqwMC0erWWtIsqyc4T8qm/Eia8gkKxtIKyWyZSHwjsrCwcu2igCtDGNgBdC5EjoWvAhfcVFGCmKQwbdELcrGjRM=
X-Received: by 2002:a92:1090:: with SMTP id 16mr87933739ilq.298.1578408057283;
 Tue, 07 Jan 2020 06:40:57 -0800 (PST)
MIME-Version: 1.0
References: <20191230102942.18395-1-jinpuwang@gmail.com> <20191230102942.18395-13-jinpuwang@gmail.com>
 <6584a511-6d4d-e0e3-453a-c55256bf023b@acm.org>
In-Reply-To: <6584a511-6d4d-e0e3-453a-c55256bf023b@acm.org>
From:   Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date:   Tue, 7 Jan 2020 15:40:46 +0100
Message-ID: <CAMGffE=y14ihqk49k9drCx1Fm2HNzszAr=p-wjXx=T_TpeMqUA@mail.gmail.com>
Subject: Re: [PATCH v6 12/25] rtrs: server: sysfs interface functions
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jack Wang <jinpuwang@gmail.com>, linux-block@vger.kernel.org,
        linux-rdma@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Danil Kipnis <danil.kipnis@cloud.ionos.com>, rpenyaev@suse.de
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jan 2, 2020 at 11:06 PM Bart Van Assche <bvanassche@acm.org> wrote:
>
> On 12/30/19 2:29 AM, Jack Wang wrote:
> > +static struct kobj_attribute rtrs_srv_disconnect_attr =
> > +     __ATTR(disconnect, 0644,
> > +            rtrs_srv_disconnect_show, rtrs_srv_disconnect_store);
>
> Could __ATTR_RW() have been used here?
>
> > +static struct kobj_attribute rtrs_srv_hca_port_attr =
> > +     __ATTR(hca_port, 0444, rtrs_srv_hca_port_show, NULL);
>
> Could __ATTR_RO() have been used here?
>
> Thanks,
>
> Bart.
both case can be used, but I prefer to keep the rtrs_srv prefix.
Thanks Bart.
