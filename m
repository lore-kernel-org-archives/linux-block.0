Return-Path: <SRS0=iXKq=N6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F85CC43441
	for <linux-block@archiver.kernel.org>; Mon, 19 Nov 2018 14:56:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61A8F20851
	for <linux-block@archiver.kernel.org>; Mon, 19 Nov 2018 14:56:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61A8F20851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729399AbeKTBUq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 19 Nov 2018 20:20:46 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37788 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729376AbeKTBUp (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 19 Nov 2018 20:20:45 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 30FC180467;
        Mon, 19 Nov 2018 14:56:55 +0000 (UTC)
Received: from localhost (unknown [10.18.25.149])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 43AE81019627;
        Mon, 19 Nov 2018 14:56:51 +0000 (UTC)
Date:   Mon, 19 Nov 2018 09:56:50 -0500
From:   Mike Snitzer <snitzer@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org,
        Keith Busch <keith.busch@intel.com>,
        Sagi Grimberg <sagi@grimberg.me>, axboe@kernel.dk,
        Martin Wilck <mwilck@suse.com>, lijie <lijie34@huawei.com>,
        xose.vazquez@gmail.com, chengjike.cheng@huawei.com,
        shenhong09@huawei.com, dm-devel@redhat.com,
        wangzhoumengjian@huawei.com, christophe.varoqui@opensvc.com,
        bmarzins@redhat.com, sschremm@netapp.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: nvme: allow ANA support to be independent of native multipathing
Message-ID: <20181119145650.GB13470@redhat.com>
References: <20181114174746.GA18526@redhat.com>
 <87c931e5-4ac9-1795-8d40-cc5541d3ebcf@suse.de>
 <20181115174605.GA19782@redhat.com>
 <20181116091458.GA17267@lst.de>
 <37098edd-4dea-b58f-bca6-3be9af8ec4ee@suse.de>
 <20181116094947.GA19296@lst.de>
 <bbaf4637-209c-5cfe-2749-3fcc54f7a35f@suse.de>
 <20181116101752.GA21531@lst.de>
 <20181116192802.GA30057@redhat.com>
 <20181119093938.GA11757@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181119093938.GA11757@lst.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Mon, 19 Nov 2018 14:56:55 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Nov 19 2018 at  4:39am -0500,
Christoph Hellwig <hch@lst.de> wrote:

> On Fri, Nov 16, 2018 at 02:28:02PM -0500, Mike Snitzer wrote:
> > You rejected the idea of allowing fine-grained control over whether
> > native NVMe multipathing is enabled or not on a per-namespace basis.
> > All we have is the coarse-grained nvme_core.multipath=N knob.  Now
> > you're forecasting removing even that.  Please don't do that.
> 
> The whole point is that this hook was intended as a band aid for the
> hypothetical pre-existing setups.  Not ever for new development.

It pains me that you're marching us towards increased conflict that
needs resolution through more formal means.  And that now I'm going to
have to document the timeline of your authoritarian approach to
stifling another Linux maintainer's freedom to do his job of delivering
on functionality I've been depended on for many years.

> > Please, PLEASE take v2 of this patch.. please? ;)
> 
> See the previous mail for the plan ahead.   I'm sick and tired of you
> trying to sneak your new developemts back in.

I've only ever posted patches in the open and never has it been with the
idea of sneaking anything in.  Miscategorizing my actions as such is a
gross abuse that I will not tolerate.

If we were to confine ourselves to this v2 patch I pleaded with you to
take: https://lkml.org/lkml/2018/11/17/4

1) Hannes proposed a simplistic patch that didn't account for the fact
   that NVMe's ana workqueue wouldn't get kicked, his intent was to make
   ANA work independent of your native multipathing.  (The fact he or I
   even need to post such patches, to unwind your tight-coupling of ANA
   and multipathing, speaks to how you've calculatingly undermined any
   effort to implement proper NVMe multipathing outside of the NVMe
   driver)

2) ANA and multipathing are completely disjoint on an NVMe spec level.
   You know this.

SO: will you be taking my v2 patch for 4.21 or not?

Please advise, thanks.
Mike
