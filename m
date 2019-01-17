Return-Path: <SRS0=sC6v=PZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B602CC43387
	for <linux-block@archiver.kernel.org>; Thu, 17 Jan 2019 14:59:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8551420851
	for <linux-block@archiver.kernel.org>; Thu, 17 Jan 2019 14:59:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20150623.gappssmtp.com header.i=@toxicpanda-com.20150623.gappssmtp.com header.b="oV7BEDBA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727820AbfAQO7k (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 17 Jan 2019 09:59:40 -0500
Received: from mail-yw1-f65.google.com ([209.85.161.65]:37249 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727713AbfAQO7j (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 17 Jan 2019 09:59:39 -0500
Received: by mail-yw1-f65.google.com with SMTP id h193so3934302ywc.4
        for <linux-block@vger.kernel.org>; Thu, 17 Jan 2019 06:59:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LDDsSpq+mO8vIUNPeFKGo5vWZWulbkPN3dXVFvCKkl0=;
        b=oV7BEDBAU11d0r9ImgPnoT3m/33OFM6y+CtARoAQekVl3iO7nJxKne6eckto4nAuxb
         JaH+fpu//12lXERzCTOPkknb+IYsknOhlarVlYgkcIKM/WOcC67f0S+tVK7bJHTQll8O
         3zw75mw15oC9ih0AtN9EMXJKWHSLAUfDH2otkXealjAD5y4hj//ER6UOVajBqZ4CKoD4
         qH7lpTlPxND6qeNfdKxi86qdxgywW2Dfc8rqY+EZ3rHYmBG0dNVVS5EzLqghhZ8t33yf
         TFQBYi238j/KTXgIVD+OAiYE5JwvRBWK6L2OmFlN2c5nX9Zrdi3SADXrkEejgq3XeW0f
         eVBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LDDsSpq+mO8vIUNPeFKGo5vWZWulbkPN3dXVFvCKkl0=;
        b=BJ9cFWiagXhF5Q/GmaKhVIB6VUZIERK1wbIAqA6o4OOeRwuRdb2odAhdRNNRhdzRjz
         AEBVC8owyh/wqMtwYPUeAokeEBJvJNsRy8InTMCFVxH8msl60jICR0ddXTayJm+IJpwh
         pkISdB3zdHCY+CKxlNCEnETwo+IgzzJju05MMIyJBIlrtbdBaVMQyG49o+gNYW4IIRmV
         nYmhnho4yqVZBg8vhncOKU9HlvUMMGiThrhs3dWwJyKfqN/XHqv0Q5QUbnXT6tc1KYdJ
         NONI/AfzorPFJ9scCiZzpN4fZGp1uxAtWSTRVB9/3nsY13kEmF5PojeQx/VaGIhmJ3qz
         3x5A==
X-Gm-Message-State: AJcUukdxVjtQ6BJLcvrHOd6Ml9TlK9cA0CS3TpONMW5y8WXAlQo0tcQn
        0mRxzRSRMxcDh3tiVaNOYXVWeQ==
X-Google-Smtp-Source: ALg8bN6FtTzlkdflF38aarUrd5E+iOyoXR1IS781xl5Ua1ZJ5rFTUcELXn3b/eY0X2dT+MBXUunkdQ==
X-Received: by 2002:a0d:d386:: with SMTP id v128mr13185655ywd.449.1547737178354;
        Thu, 17 Jan 2019 06:59:38 -0800 (PST)
Received: from localhost ([2620:10d:c091:180::1:ec74])
        by smtp.gmail.com with ESMTPSA id v191sm717667ywc.102.2019.01.17.06.59.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Jan 2019 06:59:37 -0800 (PST)
Date:   Thu, 17 Jan 2019 09:59:37 -0500
From:   Josef Bacik <josef@toxicpanda.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Omar Sandoval <osandov@osandov.com>,
        Josef Bacik <josef@toxicpanda.com>,
        linux-block@vger.kernel.org, kernel-team@fb.com, osandov@fb.com
Subject: Re: [PATCH 1/3] blktests: add cgroup2 infrastructure
Message-ID: <20190117145936.yn5lbom54d2v52yz@macbook-pro-91.dhcp.thefacebook.com>
References: <20181204174733.7423-1-josef@toxicpanda.com>
 <20181204174733.7423-2-josef@toxicpanda.com>
 <1211bf78-c442-ea71-9e71-f6d86681ed56@acm.org>
 <1547570441.83374.112.camel@acm.org>
 <20190117014039.GA25494@vader>
 <781ed848-e7a1-47c7-12d1-4260f1e8924b@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <781ed848-e7a1-47c7-12d1-4260f1e8924b@acm.org>
User-Agent: NeoMutt/20180716
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jan 16, 2019 at 06:31:51PM -0800, Bart Van Assche wrote:
> On 1/16/19 5:40 PM, Omar Sandoval wrote:
> > On Tue, Jan 15, 2019 at 08:40:41AM -0800, Bart Van Assche wrote:
> > > On Tue, 2019-01-01 at 19:13 -0800, Bart Van Assche wrote:
> > > > On 12/4/18 9:47 AM, Josef Bacik wrote:
> > > > > In order to test io.latency and other cgroup related things we need some
> > > > > supporting helpers to setup and tear down cgroup2.  This adds support
> > > > > for checking that we can even configure cgroup2 things, set them up if
> > > > > need be, and then add the cleanup stuff to the main cleanup function so
> > > > > everything is always in a clean state.
> > > > 
> > > > Is this the patch that went in as commit ae7daae7e35a ("blktests: add
> > > > cgroup2 infrastructure")? I think that commit introduced a regression.
> > > > With that patch applied the SRP tests fail as follows:
> > > > 
> > > > # ./check -q srp/001
> > > > srp/001 (Create and remove LUNs)
> > > >       runtime  4.067s  ...
> > > > common/cgroup: line 25: CGROUP2_DIR: unbound variable
> > > > 
> > > > Is this a known issue?
> > > 
> > > Hi Josef,
> > > 
> > > Had you noticed this e-mail?
> > > 
> > > Thanks,
> > > 
> > > Bart.
> > 
> > Hey, Bart, I just pushed a fix for this:
> > 
> > commit 8a274578e2895b9f0b66c09f3a8f63b5ff1293b2
> > Author: Omar Sandoval <osandov@fb.com>
> > Date:   Wed Jan 16 17:34:19 2019 -0800
> > 
> >      cgroup: test if CGROUP2_DIR is set with -v instead of -n
> >      common/multipath-over-rdma does set -u, so -n "$CGROUP2_DIR" fails with
> >      an unbound variable error. Instead, use -v to test if the variable was
> >      set.
> >      Signed-off-by: Omar Sandoval <osandov@fb.com>
> > 
> > diff --git a/common/cgroup b/common/cgroup
> > index 48e546f..554ebf7 100644
> > --- a/common/cgroup
> > +++ b/common/cgroup
> > @@ -22,7 +22,7 @@ _init_cgroup2()
> >   _exit_cgroup2()
> >   {
> > -	if [[ -n $CGROUP2_DIR ]]; then
> > +	if [[ -v CGROUP2_DIR ]]; then
> >   		find "$CGROUP2_DIR" -type d -delete
> >   		unset CGROUP2_DIR
> >   	fi
> 
> That change looks good to me. Thanks!
> 

Hmm sorry Bart, I wasn't trying to ignore you, your email ended up in a folder
for some reason and I didn't see this until Omar sent his patch.  Thanks,

Josef
