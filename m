Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD504C4338F
	for <linux-block@archiver.kernel.org>; Thu, 12 Aug 2021 08:59:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8ACE861077
	for <linux-block@archiver.kernel.org>; Thu, 12 Aug 2021 08:59:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235505AbhHLI7u (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 12 Aug 2021 04:59:50 -0400
Received: from verein.lst.de ([213.95.11.211]:43476 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235158AbhHLI7t (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 12 Aug 2021 04:59:49 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 9677E68AFE; Thu, 12 Aug 2021 10:59:23 +0200 (CEST)
Date:   Thu, 12 Aug 2021 10:59:22 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Dan Schatzberg <schatzberg.dan@gmail.com>
Subject: Re: [PATCH V4 2/7] loop: clean up blkcg association
Message-ID: <20210812085922.GD2867@lst.de>
References: <20210806080302.298297-1-ming.lei@redhat.com> <20210806080302.298297-3-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210806080302.298297-3-ming.lei@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Aug 06, 2021 at 04:02:57PM +0800, Ming Lei wrote:
>  	return !css || css == blkcg_root_css;
>  }
> +static struct cgroup_subsys_state *loop_rq_blkcg_css(struct loop_cmd *cmd)

Please keep an empty line after each function.
