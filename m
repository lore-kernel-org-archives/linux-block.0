Return-Path: <SRS0=2amJ=TA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AFDBC43219
	for <linux-block@archiver.kernel.org>; Tue, 30 Apr 2019 10:11:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0972A21670
	for <linux-block@archiver.kernel.org>; Tue, 30 Apr 2019 10:11:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556619086;
	bh=o1wMCDHFwGgVwrps+DSjmA5A0wEtpqb0cJ+nZ5axszI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=fdI7LrJxP/T00Xflyix8WxBKVf94eCUKPMzj3//XiDqLdOC71H3ewmvprsTcNezCJ
	 frRaeH6Fol3mdb6c3zAD/GsuWIJqK9DWUR6yKZsm2PN9DvVVK58lJ2LokEElQ179aQ
	 mUjW84LsLB48QIrHcHIyL4HCDry17eT53X+w4bXA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726648AbfD3KLZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 30 Apr 2019 06:11:25 -0400
Received: from mx2.suse.de ([195.135.220.15]:49236 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726539AbfD3KLZ (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 30 Apr 2019 06:11:25 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B4ED0AF56;
        Tue, 30 Apr 2019 10:11:23 +0000 (UTC)
Date:   Tue, 30 Apr 2019 06:11:20 -0400
From:   Michal Hocko <mhocko@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Jens Axboe <axboe@kernel.dk>, Jerome Glisse <jglisse@redhat.com>,
        lsf-pc@lists.linux-foundation.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: Scheduling conflicts
Message-ID: <20190430101120.GD3715@dhcp22.suse.cz>
References: <20190425200012.GA6391@redhat.com>
 <83fda245-849a-70cc-dde0-5c451938ee97@kernel.dk>
 <20190429235440.GA13796@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190429235440.GA13796@bombadil.infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon 29-04-19 16:54:41, Matthew Wilcox wrote:
> On Thu, Apr 25, 2019 at 02:03:34PM -0600, Jens Axboe wrote:
> > On 4/25/19 2:00 PM, Jerome Glisse wrote:
> > > Did i miss preliminary agenda somewhere ? In previous year i think
> > > there use to be one by now :)
> > 
> > You should have received an email from LF this morning with a subject
> > of:
> > 
> > LSFMM 2019: 8 Things to Know Before You Arrive!
> > 
> > which also includes a link to the schedule. Here it is:
> > 
> > https://docs.google.com/spreadsheets/d/1Z1pDL-XeUT1ZwMWrBL8T8q3vtSqZpLPgF3Bzu_jejfk
> 
> The schedule continues to evolve ... I would very much like to have
> Christoph Hellwig in the room for the Eliminating Tail Pages discussion,
> but he's now scheduled to speak in a session at the same time (16:00
> Tuesday).  I assume there'll be time for agenda-bashing at 9am tomorrow?

I have swapped slots at 16:00 and 16:30 so there shouldn't be any
conflict now. Let me know if that doesn't fit.

-- 
Michal Hocko
SUSE Labs
