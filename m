Return-Path: <SRS0=2cC7=AA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4456CC433DF
	for <linux-block@archiver.kernel.org>; Fri, 19 Jun 2020 15:36:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 24423206FA
	for <linux-block@archiver.kernel.org>; Fri, 19 Jun 2020 15:36:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592580989;
	bh=u/CdtheCagNnozUz5p3gqXOp6mrR7D99Q7P2/ig3Prg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=oxV8LMpU95hnyiiJvY8+HJFu1R0XbMaaoAoWEFfgQj7INH35q2a7QXxh7ZN1Ckcbn
	 yRC+HWPTI3JbcxcvkfchioK82fJoyQa19VZnqFJArHwWqw9DkRy0c0Fv2UqOSY1s/5
	 hxZqwttx8g6TM4VSY7JjsUdOymxgcGZMZI6zysYs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404879AbgFSPg1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 19 Jun 2020 11:36:27 -0400
Received: from mail-pj1-f67.google.com ([209.85.216.67]:56178 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391695AbgFSPgY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 19 Jun 2020 11:36:24 -0400
Received: by mail-pj1-f67.google.com with SMTP id ne5so4198232pjb.5;
        Fri, 19 Jun 2020 08:36:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LjzrirVb+ZQBftcrRnoHLV9aRjuJIVfcPAYJhueLEQk=;
        b=j5o5tO1tyDDGisXMWl6kWkDjdFhK2FjznjMc5EuwqXD/hVXUn54Cd94YxgQvB2eKm5
         B3jQgLkjJ2auPVeSKVfjQjzc0alqO1f5jAraGYVl2fe3PDCKTSfwszZONn0pQX8QsP+X
         pF2piML2/z4jHogDjdDkJzV3RHPbYiKytxjF8KSOfODkMaeuGn50tI1E5Q1eQhu9OzjV
         BCq41297JQ1QAL/uxF9WRufJY4CeNYNhRLhVOr9mb1GY0S0nyMmR0GfMnf/vsH5llkdS
         +Hag2VWUTm7flab+tFX4zfhVskY/PjsOBLq+nCKjDgRiMuc884h+CeWsI+IlpJgbZ8YU
         bN1Q==
X-Gm-Message-State: AOAM530ZiggpUZSitQ2Wb9nvdQwVhV0pv5Wny6SJA8ksO2SGdygu3nMn
        Fdomf+a3jIMvmvnEPbRCM5s=
X-Google-Smtp-Source: ABdhPJzViKsR3tVw6K/ch+JBLdo17uGcti8CT335conquQT26tgspJ89pJQG6ng0CCGMq0+rPtsHZQ==
X-Received: by 2002:a17:902:b906:: with SMTP id bf6mr8845200plb.129.1592580983204;
        Fri, 19 Jun 2020 08:36:23 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id p16sm5382348pgj.53.2020.06.19.08.36.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2020 08:36:21 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id CD1B84063E; Fri, 19 Jun 2020 15:36:20 +0000 (UTC)
Date:   Fri, 19 Jun 2020 15:36:20 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     axboe@kernel.dk, viro@zeniv.linux.org.uk,
        gregkh@linuxfoundation.org, rostedt@goodmis.org, mingo@redhat.com,
        jack@suse.cz, ming.lei@redhat.com, nstange@suse.de,
        akpm@linux-foundation.org, mhocko@suse.com, yukuai3@huawei.com,
        martin.petersen@oracle.com, jejb@linux.ibm.com,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Omar Sandoval <osandov@fb.com>,
        Hannes Reinecke <hare@suse.com>,
        Michal Hocko <mhocko@kernel.org>,
        syzbot+603294af2d01acfdd6da@syzkaller.appspotmail.com
Subject: Re: [PATCH v6 6/6] blktrace: fix debugfs use after free
Message-ID: <20200619153620.GI11244@42.do-not-panic.com>
References: <20200608170127.20419-1-mcgrof@kernel.org>
 <20200608170127.20419-7-mcgrof@kernel.org>
 <ec643803-2339-fe8d-7f58-b37871c83386@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ec643803-2339-fe8d-7f58-b37871c83386@acm.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Jun 12, 2020 at 07:42:12PM -0700, Bart Van Assche wrote:
> On 2020-06-08 10:01, Luis Chamberlain wrote:
> > +	/*
> > +	 * Blktrace needs a debugfs name even for queues that don't register
> > +	 * a gendisk, so it lazily registers the debugfs directory.  But that
> > +	 * can get us into a situation where a SCSI device is found, with no
> > +	 * driver for it (yet).  Then blktrace is used on the device, creating
> > +	 * the debugfs directory, and only after that a driver is loaded. In
> > +	 * that case we might already have a debugfs directory registered here.
> > +	 * Even worse we could be racing with blktrace to register it.
> > +	 */
> 
> There are LLD and ULD drivers in the SCSI subsystem. Please mention the
> driver type explicitly. I assume that you are referring to SCSI ULDs
> since only SCSI ULD drivers call device_add_disk()?

I've simplified this and so this is no longer a valid comment.

> >  	case BLKTRACESETUP:
> > +		if (!sdp->device->request_queue->sg_debugfs_dir)
> > +			blk_sg_debugfs_init(sdp->device->request_queue,
> > +					    sdp->disk->disk_name);
> 
> How about moving the sg_debugfs_dir check into blk_sg_debugfs_init()?

I found a way to not have to do any of this, the fix will be short and
sweet now.

  Luis
