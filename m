Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9E16C433EF
	for <linux-block@archiver.kernel.org>; Wed,  3 Nov 2021 13:03:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C09A660F90
	for <linux-block@archiver.kernel.org>; Wed,  3 Nov 2021 13:03:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230152AbhKCNFy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 3 Nov 2021 09:05:54 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:46046 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230282AbhKCNFx (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 3 Nov 2021 09:05:53 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id B13D31FD2F;
        Wed,  3 Nov 2021 13:03:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1635944596; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kERbFomJtixBSTf3DWzetUiiZGKnZYtXYJTmsvXJBN0=;
        b=oHYRtCvtUZaaev+8ylQRtHFmy9evH2fsjVR90cUDv5sWBjt9vvIqy4vmq9BmgObBi+ako5
        Gjjiq/aYqDNxIf2/W5KmPqulBGRJGYyrIoyJc0dYM5Nz+7Nc01EXmc7VN9FWQLJkOjxLk2
        sYOtWli4N3Z9e2Ap1YapkPKUcpbLWsg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1635944596;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kERbFomJtixBSTf3DWzetUiiZGKnZYtXYJTmsvXJBN0=;
        b=UokhT6tkK5Qc/c2rjP+8q6evDRE9QtE2yJC7/eBsM4P+l0CsfsHF6MIFDNb/3eMdmKvuPb
        qWJOkDqUOMc3t4Cw==
Received: from quack2.suse.cz (jack.udp.ovpn1.nue.suse.de [10.163.28.18])
        by relay2.suse.de (Postfix) with ESMTP id D6E152C144;
        Wed,  3 Nov 2021 13:03:12 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 156EC1E10D0; Wed,  3 Nov 2021 14:03:14 +0100 (CET)
Date:   Wed, 3 Nov 2021 14:03:14 +0100
From:   Jan Kara <jack@suse.cz>
To:     Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Cc:     Jan Kara <jack@suse.cz>, Paolo Valente <paolo.valente@linaro.org>,
        linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 4/8] bfq: Limit number of requests consumed by each cgroup
Message-ID: <20211103130314.GC20482@quack2.suse.cz>
References: <20211006164110.10817-1-jack@suse.cz>
 <20211006173157.6906-4-jack@suse.cz>
 <20211102181658.GA63407@blackbody.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211102181658.GA63407@blackbody.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello,

On Tue 02-11-21 19:16:58, Michal Koutný wrote:
> On Wed, Oct 06, 2021 at 07:31:43PM +0200, Jan Kara <jack@suse.cz> wrote:
> > +	for (level--; level >= 0; level--) {
> > +		entity = entities[level];
> > +		if (level > 0) {
> > +			wsum = bfq_entity_service_tree(entity)->wsum;
> > +		} else {
> > +			int i;
> > +			/*
> > +			 * For bfqq itself we take into account service trees
> > +			 * of all higher priority classes and multiply their
> > +			 * weights so that low prio queue from higher class
> > +			 * gets more requests than high prio queue from lower
> > +			 * class.
> > +			 */
> > +			wsum = 0;
> > +			for (i = 0; i <= class_idx; i++) {
> > +				wsum = wsum * IOPRIO_BE_NR +
> > +					sched_data->service_tree[i].wsum;
> > +			}
> > +		}
> > +		limit = DIV_ROUND_CLOSEST(limit * entity->weight, wsum);
> 
> This scheme caught my eye. You mutliply (tree) weights by a factor
> depending on the class when counting the wsum but then you don't apply
> the same scaling for the evaluated entity in the numerator.

Since we stop the loop at bfq_class_idx(entity) I don't think scaling of
the numerator makes sense - effectively when all the processes having IO to
submit (these are accounted in wsum) are in the same IO priority class, the
above code collapses to just:

  limit = limit * entity->weight / sched_data->service_tree[bfq_class_idx(entity)].wsum

I.e., we scale available tags proportionally to bfq_queue weight (which
scales linearly with IO priority).

When there are processes say both in RT and BE IO priority classes, then a
process in RT class still uses the above formula - i.e., as if all tags
available for a cgroup are split proportionally only among active tasks in
RT IO priority class. So in principle it can happen that there would be no
tag left for a process in lower IO priority class - and that is fine, we
don't care, because we don't want to submit IO from lower IO priority class
while there is still IO in higher IO priority class.

Now consider a situation for a process in BE IO priority class in this
setting. All processes in BE class can together occupy at most BE_wsum /
(RT_wsum * IOPRIO_BE_NR + BE_wsum) fraction of tags. This is admittedly
somewhat arbitrary fraction but it makes sure for each process in RT class
there are at least as many tags left as for the highest priority process in
BE class.

> IOW, I think there should be something like
> 	scale = (level > 0) ? 1 : int_pow(IOPRIO_BE_NR, BFQ_IOPRIO_CLASSES - bfq_class_idx(entity));
> 	limit = DIV_ROUND_CLOSEST(limit * entity->weight * scale, wsum);
> 
> For instance, if there are two cgroups (level=1) with weights 100 and
> 200, and each cgroup has a single IOPRIO_CLASS_BE entity (level=0) in
> it, the `limit` distribution would honor the ratio of weights from
> level=1 (100:200) but it would artificially lower the absolute amount of
> allowed tags. If I am not mistaken, that would be reduced by factor
> 1/BFQ_IOPRIO_CLASSES.

I don't see where my code would lead to available number of tags being
artifically lower as you write - in your example wsum for RT class would be
0 so effectively all terms of the formula for that class will cancel out.
As I wrote above, the highest active IO priority class effectively allows
processes in this class to consume all tags available for a cgroup. If
there are lower IO priority classes active as well, we allow them to
consume some tags but never allow them to consume all of them...

> Also if I consider it more broadly, is this supposed to match/extend
> bfq_io_prio_to_weight() calculation?

Yes, this is kind of an extension of bfq_io_prio_to_weight() that allows
some comparison of queues from different IO priority classes.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
