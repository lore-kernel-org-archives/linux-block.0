Return-Path: <SRS0=3ryC=6E=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97A8BC55181
	for <linux-block@archiver.kernel.org>; Mon, 20 Apr 2020 21:51:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 71F4A20857
	for <linux-block@archiver.kernel.org>; Mon, 20 Apr 2020 21:51:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587419511;
	bh=ARynByPt6K845Y1WKAWZFIjRAWGpQIaOXNbufeYGcSY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=uETOqBrcbJOHuK7pckmCQ6v059nb4f8L/6PguwgqZTydTtsFPPQxHhy8Ak7mV0pyG
	 Y0G/f9Yyweo/45kj6AaPzuefhSChE3dcpKCXS0kvvvAzxGzwppFcIpgTiFll1NdR5z
	 PGzEUccnbWxLy9lfFGcPOeeRhdqv6dpBCNV/xIj0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726181AbgDTVvv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 20 Apr 2020 17:51:51 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:45274 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725989AbgDTVvu (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 20 Apr 2020 17:51:50 -0400
Received: by mail-pf1-f193.google.com with SMTP id w65so5590197pfc.12;
        Mon, 20 Apr 2020 14:51:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VgKKIxe7DirK2QHauC8VINdT+s5Rf3r97F/D9e91FTk=;
        b=H96w90Jl+0udPwrk0fCuqQ5ZsyVIC8IZoYI77IhJGNEG2sEptZpqUxkctZwCQMARnF
         6vyPxwKIy7SDQqZqCnSMMSRvV2tyQuhMeOjvjuUva0z1/TKyhHR7/23Uu2zd3psGuYjL
         DhZzOrD9H0/aPIPYA2HahtqVugVmODTF37HulnZByflKnEhGgVc0PJK9f57fTmVZ98Mf
         UfOHTumgzsM8VeVN/Psj/geeHP68s5RzL2LlGXKlCz1qbj10OEy8rEVou2uIYucL5uDe
         +jx+bcdAftS3XBhF+7nctnCWFeSOZrupZ5yUqzy3Oz+HjgYcdoZeF7gBJngY2f7XYOWY
         WBcQ==
X-Gm-Message-State: AGi0PuZzuoRhA1o+6Ize/xHNEXBfusvlsZXE+VuAP6LOqNWvtGDMIQom
        KXJY0RV1o/AUJi/TxdF58Q8=
X-Google-Smtp-Source: APiQypJn1hT4fbB9tcubgpiWGRaRQPxvG+yu2nN4pARSrEYvbs5rxdCSMPSxa0mg9FkB0ytg6Ag33w==
X-Received: by 2002:aa7:9302:: with SMTP id 2mr18486299pfj.256.1587419509699;
        Mon, 20 Apr 2020 14:51:49 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id z15sm355748pjt.20.2020.04.20.14.51.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2020 14:51:48 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 0A6DB4028E; Mon, 20 Apr 2020 21:51:48 +0000 (UTC)
Date:   Mon, 20 Apr 2020 21:51:47 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     axboe@kernel.dk, viro@zeniv.linux.org.uk,
        gregkh@linuxfoundation.org, rostedt@goodmis.org, mingo@redhat.com,
        jack@suse.cz, ming.lei@redhat.com, nstange@suse.de,
        akpm@linux-foundation.org, mhocko@suse.com, yukuai3@huawei.com,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Omar Sandoval <osandov@fb.com>,
        Hannes Reinecke <hare@suse.com>,
        Michal Hocko <mhocko@kernel.org>
Subject: Re: [PATCH v2 04/10] block: revert back to synchronous request_queue
 removal
Message-ID: <20200420215147.GP11244@42.do-not-panic.com>
References: <20200419194529.4872-1-mcgrof@kernel.org>
 <20200419194529.4872-5-mcgrof@kernel.org>
 <749d56bd-1d66-e47b-a356-8d538e9c99b4@acm.org>
 <20200420185943.GM11244@42.do-not-panic.com>
 <eba2a91b-62a6-839d-df54-2a1cf8262652@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eba2a91b-62a6-839d-df54-2a1cf8262652@acm.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Apr 20, 2020 at 02:11:13PM -0700, Bart Van Assche wrote:
> On 4/20/20 11:59 AM, Luis Chamberlain wrote:
> > On Sun, Apr 19, 2020 at 03:23:31PM -0700, Bart Van Assche wrote:
> > > On 4/19/20 12:45 PM, Luis Chamberlain wrote:
> > > > + * Decrements the refcount to the request_queue kobject, when this reaches
> > > > + * 0 we'll have blk_release_queue() called. You should avoid calling
> > > > + * this function in atomic context but if you really have to ensure you
> > > > + * first refcount the block device with bdgrab() / bdput() so that the
> > > > + * last decrement happens in blk_cleanup_queue().
> > > > + */
> > > 
> > > Is calling bdgrab() and bdput() an option from a context in which it is not
> > > guaranteed that the block device is open?
> > 
> > If the block device is not open, nope. For that blk_get_queue() can
> > be used, and is used by the block layer. This begs the question:
> > 
> > Do we have *drivers* which requires access to the request_queue from
> > atomic context when the block device is not open?
> 
> Instead of trying to answer that question, how about changing the references
> to bdgrab() and bdput() into references to blk_get_queue() and
> blk_put_queue()? I think if that change is made that we won't have to
> research what the answer to the bdgrab()/bdput() question is.

Yeah that's fine, now at least we'd have documented what should be avoided.

  Luis
