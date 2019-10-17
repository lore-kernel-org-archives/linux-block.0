Return-Path: <SRS0=WMYH=YK=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6ABAECE58D
	for <linux-block@archiver.kernel.org>; Thu, 17 Oct 2019 19:37:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B911B20640
	for <linux-block@archiver.kernel.org>; Thu, 17 Oct 2019 19:37:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394049AbfJQThR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 17 Oct 2019 15:37:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:5549 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728856AbfJQThR (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 17 Oct 2019 15:37:17 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 73C45308FFB1;
        Thu, 17 Oct 2019 19:37:16 +0000 (UTC)
Received: from rt4.app.eng.rdu2.redhat.com (rt4.app.eng.rdu2.redhat.com [10.10.161.56])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4943C19C70;
        Thu, 17 Oct 2019 19:37:16 +0000 (UTC)
Received: from rt4.app.eng.rdu2.redhat.com (localhost [127.0.0.1])
        by rt4.app.eng.rdu2.redhat.com (8.14.4/8.14.4) with ESMTP id x9HJbFjn017092;
        Thu, 17 Oct 2019 15:37:15 -0400
Received: (from apache@localhost)
        by rt4.app.eng.rdu2.redhat.com (8.14.4/8.14.4/Submit) id x9HJbECL017089;
        Thu, 17 Oct 2019 15:37:14 -0400
From:   Red Hat Product Security <secalert@redhat.com>
X-PGP-Public-Key: https://www.redhat.com/security/650d5882.txt
Subject: [engineering.redhat.com #498403] Re: [PATCH v2] nbd_genl_status: null check for nla_nest_start
Reply-To: secalert@redhat.com
In-Reply-To: <CAEkB2ES8rc4kkPwA+okfMa9CpFoDqmt=tx8H8vHZKBCfw9L_tg@mail.gmail.com>
References: <RT-Ticket-498403@engineering.redhat.com>
 <20190729130912.7imtg3hfnvb4lt2y@MacBook-Pro-91.local>
 <20190729164226.22632-1-navid.emamdoost@gmail.com>
 <20190910113521.GA9895@unicorn.suse.cz>
 <CAEkB2ES8rc4kkPwA+okfMa9CpFoDqmt=tx8H8vHZKBCfw9L_tg@mail.gmail.com>
Message-ID: <rt-4.0.13-16866-1571341034-901.498403-5-0@engineering.redhat.com>
X-RT-Loop-Prevention: engineering.redhat.com
RT-Ticket: engineering.redhat.com #498403
Managed-BY: RT 4.0.13 (http://www.bestpractical.com/rt/)
RT-Originator: kbost@redhat.com
To:     navid.emamdoost@gmail.com
CC:     axboe@kernel.dk, emamd001@umn.edu, josef@toxicpanda.com,
        kjlu@umn.edu, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, mkubecek@suse.cz,
        nbd@other.debian.org, smccaman@umn.edu
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
X-RT-Original-Encoding: utf-8
Date:   Thu, 17 Oct 2019 15:37:14 -0400
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Thu, 17 Oct 2019 19:37:16 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Navid,

Not sure if you meant to cc secalert@redhat.com on this. If anything is needed
from our side please let us know!

On Wed Oct 16 22:17:42 2019, navid.emamdoost@gmail.com wrote:
> Hi Michal, please check v3 at
> https://lore.kernel.org/patchwork/patch/1126650/
>
>
> Thanks,
> Navid.
>
> On Tue, Sep 10, 2019 at 6:35 AM Michal Kubecek <mkubecek@suse.cz>
> wrote:
> >
> > (Just stumbled upon this patch when link to it came with a CVE bug
> report.)
> >
> > On Mon, Jul 29, 2019 at 11:42:26AM -0500, Navid Emamdoost wrote:
> > > nla_nest_start may fail and return NULL. The check is inserted,
> and
> > > errno is selected based on other call sites within the same source
> code.
> > > Update: removed extra new line.
> > >
> > > Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
> > > Reviewed-by: Bob Liu <bob.liu@oracle.com>
> > > ---
> > > drivers/block/nbd.c | 5 +++++
> > > 1 file changed, 5 insertions(+)
> > >
> > > diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
> > > index 9bcde2325893..2410812d1e82 100644
> > > --- a/drivers/block/nbd.c
> > > +++ b/drivers/block/nbd.c
> > > @@ -2149,6 +2149,11 @@ static int nbd_genl_status(struct sk_buff
> *skb, struct genl_info *info)
> > > }
> > >
> > > dev_list = nla_nest_start_noflag(reply,
> NBD_ATTR_DEVICE_LIST);
> > > + if (!dev_list) {
> > > + ret = -EMSGSIZE;
> > > + goto out;
> > > + }
> > > +
> > > if (index == -1) {
> > > ret = idr_for_each(&nbd_index_idr, &status_cb,
> reply);
> > > if (ret) {
> >
> > You should also call nlmsg_free(reply) when you bail out so that you
> > don't introduce a memory leak.
> >
> > Michal Kubecek
>
>
>


--
Kat Bost
Red Hat Product Security

