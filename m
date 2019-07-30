Return-Path: <SRS0=ZBGg=V3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDCCFC0650F
	for <linux-block@archiver.kernel.org>; Tue, 30 Jul 2019 05:52:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE23420882
	for <linux-block@archiver.kernel.org>; Tue, 30 Jul 2019 05:52:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726234AbfG3FwE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 30 Jul 2019 01:52:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51842 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726169AbfG3FwD (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 30 Jul 2019 01:52:03 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7C74259455;
        Tue, 30 Jul 2019 05:52:03 +0000 (UTC)
Received: from rt4.app.eng.rdu2.redhat.com (rt4.app.eng.rdu2.redhat.com [10.10.161.56])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 476045DAA4;
        Tue, 30 Jul 2019 05:52:03 +0000 (UTC)
Received: from rt4.app.eng.rdu2.redhat.com (localhost [127.0.0.1])
        by rt4.app.eng.rdu2.redhat.com (8.14.4/8.14.4) with ESMTP id x6U5q270005348;
        Tue, 30 Jul 2019 01:52:02 -0400
Received: (from apache@localhost)
        by rt4.app.eng.rdu2.redhat.com (8.14.4/8.14.4/Submit) id x6U5q1aH005347;
        Tue, 30 Jul 2019 01:52:01 -0400
From:   Red Hat Product Security <secalert@redhat.com>
X-PGP-Public-Key: https://www.redhat.com/security/650d5882.txt
Subject: [engineering.redhat.com #494735] Re: [PATCH] nbd_genl_status: null check for nla_nest_start
Reply-To: secalert@redhat.com
In-Reply-To: <20190729164226.22632-1-navid.emamdoost@gmail.com>
References: <RT-Ticket-494735@engineering.redhat.com>
 <20190729130912.7imtg3hfnvb4lt2y@MacBook-Pro-91.local>
 <20190729164226.22632-1-navid.emamdoost@gmail.com>
Message-ID: <rt-4.0.13-5201-1564465920-1304.494735-5-0@engineering.redhat.com>
X-RT-Loop-Prevention: engineering.redhat.com
RT-Ticket: engineering.redhat.com #494735
Managed-BY: RT 4.0.13 (http://www.bestpractical.com/rt/)
RT-Originator: darunesh@redhat.com
To:     navid.emamdoost@gmail.com
CC:     axboe@kernel.dk, emamd001@umn.edu, josef@toxicpanda.com,
        kjlu@umn.edu, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, nbd@other.debian.org,
        smccaman@umn.edu
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
X-RT-Original-Encoding: utf-8
Date:   Tue, 30 Jul 2019 01:52:01 -0400
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Tue, 30 Jul 2019 05:52:03 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Navid,

Thank you for you report. I have forwarded this to our analysis team. Once I'll
get an update on your reported vulnerability and it's patched I'll let you
know.
Please let me know if you have any questions or concerns.

On Mon Jul 29 12:42:56 2019, navid.emamdoost@gmail.com wrote:
> nla_nest_start may fail and return NULL. The check is inserted, and
> errno is selected based on other call sites within the same source
> code.
> Update: removed extra new line.
>
> Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
> ---
> drivers/block/nbd.c | 5 +++++
> 1 file changed, 5 insertions(+)
>
> diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
> index 9bcde2325893..2410812d1e82 100644
> --- a/drivers/block/nbd.c
> +++ b/drivers/block/nbd.c
> @@ -2149,6 +2149,11 @@ static int nbd_genl_status(struct sk_buff *skb,
> struct genl_info *info)
> }
>
> dev_list = nla_nest_start_noflag(reply, NBD_ATTR_DEVICE_LIST);
> + if (!dev_list) {
> + ret = -EMSGSIZE;
> + goto out;
> + }
> +
> if (index == -1) {
> ret = idr_for_each(&nbd_index_idr, &status_cb, reply);
> if (ret) {


--
Best Regards,
Dhananjay Arunesh, Red Hat Product Security
7F45 FDD1 BB92 2DA8 CD05 F034 9B3D 8FE3 50EC 5D74

