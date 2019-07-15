Return-Path: <SRS0=FYaB=VM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4AF9C7618F
	for <linux-block@archiver.kernel.org>; Mon, 15 Jul 2019 23:07:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86A8E21738
	for <linux-block@archiver.kernel.org>; Mon, 15 Jul 2019 23:07:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=osandov-com.20150623.gappssmtp.com header.i=@osandov-com.20150623.gappssmtp.com header.b="nO7JDWku"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731661AbfGOXHf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 15 Jul 2019 19:07:35 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:43237 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731521AbfGOXHf (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 15 Jul 2019 19:07:35 -0400
Received: by mail-pl1-f196.google.com with SMTP id 4so2093181pld.10
        for <linux-block@vger.kernel.org>; Mon, 15 Jul 2019 16:07:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xm5ERYpf8xDBMsIMMEqpgHX/opm0oJBnr4ig5qE1akc=;
        b=nO7JDWkuSSVYlYAV1lm1SFqOKeBU7k6gxnehcsFT2x21a+ESXU0ippEXhoevTOPLId
         lwjqaYsNnuR3zIvqfzk7w6lymIAQr7rpO1UaguCmQ1xX4YdVpks2fH9dPASW9wW2ZVdS
         BtLCigSaoTQxnnFf0GYsqQ9eRi/Q+JkxvfRtSJEFvFJRH/MRRf24qCd+RR+HSDyswRom
         W5f3Guevmmlhek6RNJjwNu8V+Wz6N0YiWBT8+nt2cC+D7WkaqrzKl19PmDxGkRy3BBL/
         QQKzDElT/H+cMOKPDwcIzk8sN4brFH38vR88WZJ+TJrovAERF7fMiwbxaebgdLSD9i4R
         Ds1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xm5ERYpf8xDBMsIMMEqpgHX/opm0oJBnr4ig5qE1akc=;
        b=ClhBih6h0ihJfpcygrAs/YLyOUuFLKjUsAXsfNM4GFAZjOr6Oj7VzJFCtueMGaauUP
         BZlUiBaIzvETBwNg3gGZ3J2OHbqKu2PKAOljvE/dY7O5Vfw/mqALaiQp7lWQ2G4M9PVb
         SkXPr5xWV2Nhn81jJ0FrHBotNeg7CHMugKJSQdhiMZw8a4iCj/aN4hsi/rP1/e3Wh5Gl
         RG4HdZRenT4vQmfs3skUuB2dJEqmkAskgoDwmr/Q0fQFH+PoyhLok8hvnwVEd4hnK4as
         qe5R4m0F1fxUybYtNNTwpV765jQ3XvraIR7qJ+dv17n9HTkcCF9as85mTiiLkzvVYEYL
         izeQ==
X-Gm-Message-State: APjAAAWlxOAVpP+rIUsqF7XdwIBPE5YRqFdzZpwpzyk29VU2FjaqAuFs
        nC13HkyiBYb2s1FcMhYlYJla3w==
X-Google-Smtp-Source: APXvYqyya/YYukqoHalj390zEcSYsHkxdFRXscVPfyVy23LFXlpDY2hDnBnBtRsd2NvkqIwGwSx2zw==
X-Received: by 2002:a17:902:bcc4:: with SMTP id o4mr30597758pls.90.1563232054358;
        Mon, 15 Jul 2019 16:07:34 -0700 (PDT)
Received: from vader ([2620:10d:c090:200::2:f4a5])
        by smtp.gmail.com with ESMTPSA id v27sm21592917pgn.76.2019.07.15.16.07.23
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 15 Jul 2019 16:07:33 -0700 (PDT)
Date:   Mon, 15 Jul 2019 16:07:13 -0700
From:   Omar Sandoval <osandov@osandov.com>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        Omar Sandoval <osandov@fb.com>, Theodore Ts'o <tytso@mit.edu>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        Stephen Bates <sbates@raithlin.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Michael Moese <mmoese@suse.de>
Subject: Re: [PATCH blktests 02/12] nvme: More agressively filter the
 discovery output
Message-ID: <20190715230713.GA5449@vader>
References: <20190712235742.22646-1-logang@deltatee.com>
 <20190712235742.22646-3-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190712235742.22646-3-logang@deltatee.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Jul 12, 2019 at 05:57:32PM -0600, Logan Gunthorpe wrote:
> Comparing the entire output of nvme-cli for discovery is fragile
> and error prone as things change. There's already been the
> long standing issue of the generation counter mismatching
> and also some versions of nvme-cli print an extra "sq flow control
> disable supported" text[1].
> 
> Instead, filter out all but a few key values from the discovery
> text which should still be sufficient for this test and much
> less likely to be subject to churn.
> 
> [1] https://lore.kernel.org/linux-block/20190505150611.15776-4-minwoo.im.dev@gmail.com/
> 
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> ---
>  tests/nvme/002.out | 6001 --------------------------------------------
>  tests/nvme/016.out |    7 -
>  tests/nvme/017.out |    7 -
>  tests/nvme/rc      |    4 +-
>  4 files changed, 2 insertions(+), 6017 deletions(-)

[snip]

> diff --git a/tests/nvme/rc b/tests/nvme/rc
> index 22833d8ef9bb..60dc05869726 100644
> --- a/tests/nvme/rc
> +++ b/tests/nvme/rc
> @@ -120,6 +120,6 @@ _find_nvme_loop_dev() {
>  }
>  
>  _filter_discovery() {
> -	sed -r  -e "s/portid:  [0-9]+/portid:  X/" \
> -		-e "s/Generation counter [0-9]+/Generation counter X/"
> +	sed -r -e "s/Generation counter [0-9]+/Generation counter X/" |
> +		grep 'Discovery Log Number\|Log Entry\|trtype\|subnqn'
>  }

This can be done in a single sed command instead of sed + grep:

sed -rn -e 's/Generation counter [0-9]+/Generation counter X/' \
	-e '/Discovery Log Number|Log Entry|trtype|subnqn/p'
