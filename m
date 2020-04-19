Return-Path: <SRS0=58UM=6D=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82332C38A29
	for <linux-block@archiver.kernel.org>; Sun, 19 Apr 2020 23:07:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 54938212CC
	for <linux-block@archiver.kernel.org>; Sun, 19 Apr 2020 23:07:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587337654;
	bh=cTFXH+nC+zRZbE8EhghzJMgogTvzjTYaBvxKVlP+iYE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=TsevZzcSwdqgUf4OqFVGth87SCulB+zCn7eNDblOf24HY+00tIhd14clMJ059zy5Q
	 6SHDO23ROv1QNiavUVOkxsvnsPIQMdIwrug+/LTWq1ye2vLMDbNxJFbcLfKDAJ6drr
	 ZDm4ImfTzVR9i2893jNsQtpJ7CKrvfmLZbQz5NYI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725947AbgDSXHd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 19 Apr 2020 19:07:33 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:45654 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725834AbgDSXHd (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 19 Apr 2020 19:07:33 -0400
Received: by mail-pl1-f193.google.com with SMTP id t4so3224648plq.12;
        Sun, 19 Apr 2020 16:07:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tFxZ+ZZUaggPPpHpQbCDub6ZVjuhRM1u2yrwFwGS11s=;
        b=UFms+5ZF+WhFcPrgQOCp7bJUaR5PXOf0DAgPnUd7eexKBdOIkfjIsAf6iXcOc2Fy7Q
         hsaB6VXb2chUqLideX3AQckD61j3+Y52EqXXPBDpmTqSrNHAMrPOw66Ml5RRQRoKMdG/
         RNqGzjyAuvTxgLkzfh0Xl48TH3OUV9nuOYFFQUiAtzi/YpAd7eJSs+0elXvHGLtAKWIu
         5TMUpIjIh38QJEn66AWWOwGharSN/q8QUisYgda73tvTf0cSOeYli28ZY5hFP++RirOR
         kWp0bVIZ3oOHsWj8Qj+19lS2lcjS1Us28bhxGs9mkkoFXe8KQFwEB3fhFfK+FvyPxNuS
         5bNQ==
X-Gm-Message-State: AGi0Pub5i5r9G1vNM0slMbVL8KsKxEKIVLhPFyFTKUXHCfFpodWMTgdz
        Z55qS8HbL6iY2DVkb7+viOc=
X-Google-Smtp-Source: APiQypLXezuyQozND6kDt0/xmPqZ/Bzs10NpjYea6DC9fcMtQhW2OQWoIzjRAUFX8lFILoXU2v/o1Q==
X-Received: by 2002:a17:90a:a113:: with SMTP id s19mr18785003pjp.161.1587337652483;
        Sun, 19 Apr 2020 16:07:32 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id a18sm12089121pjh.25.2020.04.19.16.07.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Apr 2020 16:07:31 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id CBDD3403EA; Sun, 19 Apr 2020 23:07:30 +0000 (UTC)
Date:   Sun, 19 Apr 2020 23:07:30 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     axboe@kernel.dk, viro@zeniv.linux.org.uk,
        gregkh@linuxfoundation.org, rostedt@goodmis.org, mingo@redhat.com,
        jack@suse.cz, ming.lei@redhat.com, nstange@suse.de,
        akpm@linux-foundation.org, mhocko@suse.com, yukuai3@huawei.com,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 05/10] blktrace: upgrade warns to BUG_ON() on
 unexpected circmunstances
Message-ID: <20200419230730.GH11244@42.do-not-panic.com>
References: <20200419194529.4872-1-mcgrof@kernel.org>
 <20200419194529.4872-6-mcgrof@kernel.org>
 <54b63fd9-0c73-5fdc-b43d-6ab4aec3a00d@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <54b63fd9-0c73-5fdc-b43d-6ab4aec3a00d@acm.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sun, Apr 19, 2020 at 03:50:13PM -0700, Bart Van Assche wrote:
> On 4/19/20 12:45 PM, Luis Chamberlain wrote:
> > @@ -498,10 +498,7 @@ static struct dentry *blk_trace_debugfs_dir(struct blk_user_trace_setup *buts,
> >   	struct dentry *dir = NULL;
> >   	/* This can only happen if we have a bug on our lower layers */
> > -	if (!q->kobj.parent) {
> > -		pr_warn("%s: request_queue parent is gone\n", buts->name);
> > -		return NULL;
> > -	}
> > +	BUG_ON(!q->kobj.parent);
> 
> Does the following quote from Linus also apply to this patch: "there is NO
> F*CKING EXCUSE to knowingly kill the kernel." See also
> https://lkml.org/lkml/2016/10/4/1.

We can use WARN_ON() and keep the return NULL, sure.

  Luis
