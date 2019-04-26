Return-Path: <SRS0=I+xz=S4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73C85C43218
	for <linux-block@archiver.kernel.org>; Fri, 26 Apr 2019 05:20:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 472B62077B
	for <linux-block@archiver.kernel.org>; Fri, 26 Apr 2019 05:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556256017;
	bh=jHjp/RKUd+4qML9WHRoeuGUfUqN4FzQenu/2bfqLz8s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=shKOBvXGZxgrFSZUzDbCMfjehqU9YQB+piJW5wDk5TkkVI10JJ4yRElsmR+Nmz2p+
	 ZNtFQGYy7oGr38I537gsAt3QNzAzqNw7txYjTM0VlhVra3RdDGkIHO1uDEAE2G7jGM
	 X0vppzxWpXE9+hNTJhnGu+ITQDjk7h5KSe8FMl+c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727259AbfDZFUQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 26 Apr 2019 01:20:16 -0400
Received: from mx2.suse.de ([195.135.220.15]:41324 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725877AbfDZFUQ (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 26 Apr 2019 01:20:16 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A8130AD2B;
        Fri, 26 Apr 2019 05:20:14 +0000 (UTC)
Date:   Fri, 26 Apr 2019 07:20:13 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Jens Axboe <axboe@kernel.dk>, lsf-pc@lists.linux-foundation.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [LSF/MM TOPIC] Lightning round?
Message-ID: <20190426052013.GA12337@dhcp22.suse.cz>
References: <20190425200012.GA6391@redhat.com>
 <83fda245-849a-70cc-dde0-5c451938ee97@kernel.dk>
 <20190425211906.GH4739@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190425211906.GH4739@mit.edu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu 25-04-19 17:19:06, Theodore Ts'o wrote:
> On Thu, Apr 25, 2019 at 02:03:34PM -0600, Jens Axboe wrote:
> > 
> > which also includes a link to the schedule. Here it is:
> > 
> > https://docs.google.com/spreadsheets/d/1Z1pDL-XeUT1ZwMWrBL8T8q3vtSqZpLPgF3Bzu_jejfk
> 
> It looks like there are still quite a few open slots on Thursday?

Please note that the agenda is still not finalized. I do not know about
other tracks but MM is not complete.

> Could we perhaps schedule a session for lightning talks?

I am pretty sure there will be some room for that as well.
-- 
Michal Hocko
SUSE Labs
