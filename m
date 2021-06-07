Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81265C47082
	for <linux-block@archiver.kernel.org>; Mon,  7 Jun 2021 16:58:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4FF7661073
	for <linux-block@archiver.kernel.org>; Mon,  7 Jun 2021 16:58:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230294AbhFGRA0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 7 Jun 2021 13:00:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:50806 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230250AbhFGRAZ (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 7 Jun 2021 13:00:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B54DD60FEF;
        Mon,  7 Jun 2021 16:58:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623085114;
        bh=5yXe/by2vyZYp7WLgmqsGVz8qaFERIQWxmtpycVWR5I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Tl5ttCz3+w2/RWHkD1NqmgzHqMHWOrkufh+qUvNlpD6bvFqYav31RSV7LykiF88gB
         iktaDpkCUtXcOjG2ImNmb9N/5EDGRy+2iQzt2bKngFUnjfQkLfm5FKLyscmL2QMgjR
         +v95Ba3H7JPoPvgBUb85kkh7djFkqrZmiVoCWqBva7471yIYGFF2K7EuB6nuPglZFy
         rPKNCAuSKBkuT77NefCflOGxnXeS5nbJN8j/IihZA6PyO8HPQEo5B4nmh+V55pghWh
         CW6ZPeHSJY8J79b/ilb2AMPYkbcUGnhRssKYPZoLwlHjrNlqFmxOi2SPc+GM2OC8RJ
         5U3pOFvvJAMmQ==
Date:   Tue, 8 Jun 2021 01:58:27 +0900
From:   Keith Busch <kbusch@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-nvme@lists.infradead.org, sagi@grimberg.me, axboe@kernel.dk,
        linux-block@vger.kernel.org,
        Yuanyuan Zhong <yzhong@purestorage.com>,
        Casey Chen <cachen@purestorage.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: Re: [PATCHv3 4/4] nvme: use return value from blk_execute_rq()
Message-ID: <20210607165827.GC21631@redsun51.ssa.fujisawa.hgst.com>
References: <20210521202145.3674904-1-kbusch@kernel.org>
 <20210521202145.3674904-5-kbusch@kernel.org>
 <20210524080428.GA24488@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210524080428.GA24488@lst.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, May 24, 2021 at 10:04:28AM +0200, Christoph Hellwig wrote:
> > @@ -168,7 +167,8 @@ static void nvmet_passthru_execute_cmd_work(struct work_struct *w)
> >  			nvmet_passthru_override_id_ns(req);
> >  			break;
> >  		}
> > -	}
> > +	} else if (status < 0)
> > +		status = NVME_SC_INTERNAL;
> 
> Don't we need a better translation here?

Did you have something in mind? I couldn't think of anything more
appropriate than the generic internal error. The errno's we get here are
-EINTR or -EIO. Both indicate we can't communicate with the back-end
device, but these problems are internal to the target from the host's
perspective.
