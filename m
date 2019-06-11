Return-Path: <SRS0=2dDp=UK=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E518DC43218
	for <linux-block@archiver.kernel.org>; Tue, 11 Jun 2019 07:57:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6475208E3
	for <linux-block@archiver.kernel.org>; Tue, 11 Jun 2019 07:57:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404525AbfFKH5Z (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 11 Jun 2019 03:57:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39532 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403815AbfFKH5Z (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Jun 2019 03:57:25 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D64A02F8BF5;
        Tue, 11 Jun 2019 07:57:19 +0000 (UTC)
Received: from ming.t460p (ovpn-8-26.pek2.redhat.com [10.72.8.26])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7CD0B5D721;
        Tue, 11 Jun 2019 07:57:13 +0000 (UTC)
Date:   Tue, 11 Jun 2019 15:57:09 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        David Gibson <david@gibson.dropbear.id.au>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-xfs@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH V2 0/2] block: fix page leak by merging to same page
Message-ID: <20190611075707.GA15921@ming.t460p>
References: <20190610041819.11575-1-ming.lei@redhat.com>
 <20190610133446.GA28712@infradead.org>
 <20190610150958.GA29607@ming.t460p>
 <20190611074541.GA31787@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190611074541.GA31787@infradead.org>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Tue, 11 Jun 2019 07:57:25 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jun 11, 2019 at 12:45:41AM -0700, Christoph Hellwig wrote:
> Can you please trim your replies?  I've scrolled two patches before
> giving up trying to read your mail.

OK, next time will trim the reply.

Thanks,
Ming
