Return-Path: <SRS0=58UM=6D=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20A18C38A30
	for <linux-block@archiver.kernel.org>; Sun, 19 Apr 2020 19:48:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E4B8621744
	for <linux-block@archiver.kernel.org>; Sun, 19 Apr 2020 19:48:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587325684;
	bh=KJT1cJALkjH8IPN8SBj5aVqN0kfQwNBytF/bn6zKVfI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=niunkDToa740GIa/ZuvOiZOU8iDNLJ5KcJfNV9rlqo3rl44tG0T9C+1zMxAQ8SUev
	 ws/go+0toWq5NSz5jPypDIYrI2PTKhcBNUKDNFJPx3/qv9kHE8mrooJp5Swm61QXvo
	 wwI4/NQ//QWd30SrXdGOtxJIagtQ3cSchc38HZh4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726287AbgDSTsD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 19 Apr 2020 15:48:03 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:38492 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725932AbgDSTsD (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 19 Apr 2020 15:48:03 -0400
Received: by mail-pl1-f193.google.com with SMTP id w3so3132142plz.5;
        Sun, 19 Apr 2020 12:48:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XVDLAqmmcNsGZA6DvUaFp5wX8Hdu6VgQb85DAfNU9EE=;
        b=lOCiewXaWuIhT+rg/o8v4JApXcvRnpksTRE3Kw0vfKHLXwuVhzBcNzR0kqbhOw+Vng
         m14i67jOVvuRQr8Qn6Ms3K5d3wlRRAy4nhpO4k5asso7oy2GebtvyAW09GOuzYkr6n0u
         4pU48d6aomWuZRpuoQrLQWeHAvTX5zkNDMKFAO2N7TCTsebzfJY8EA7Ft5SEz2kag3vU
         BoVprPad7P7/XohUYkrjCARlfVkQIsqwuNR6M79D8dRXw6WeI0Lo0VpncHQCn1nSUUPk
         vAFN1KuY+1BBElsrFSfEtyYUFphI1g5kN9Z1e3YhwP1gT31Fpf/I5dJue7No/vDXfR3b
         ocPQ==
X-Gm-Message-State: AGi0PubDEqkzp2mGj+eA4IrYARxi670rslD65IhlNBmHg0WAIP+BToF9
        38L40J7qAG95ZxGTVw7OZWQ=
X-Google-Smtp-Source: APiQypL/oNNU12e6hvfturuFLEKJm2Tcw6XS1ihtc1V9GAkRooHVTN400PWDSxk8Iks2Ql8Gg519ag==
X-Received: by 2002:a17:90a:bf8c:: with SMTP id d12mr17598558pjs.11.1587325682585;
        Sun, 19 Apr 2020 12:48:02 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id z190sm23620136pgz.73.2020.04.19.12.48.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Apr 2020 12:48:01 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id F000E403EA; Sun, 19 Apr 2020 19:48:00 +0000 (UTC)
Date:   Sun, 19 Apr 2020 19:48:00 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     axboe@kernel.dk, viro@zeniv.linux.org.uk, bvanassche@acm.org,
        gregkh@linuxfoundation.org, rostedt@goodmis.org, mingo@redhat.com,
        jack@suse.cz, ming.lei@redhat.com, nstange@suse.de,
        akpm@linux-foundation.org
Cc:     mhocko@suse.com, yukuai3@huawei.com, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 00/10] block: fix blktrace debugfs use after free
Message-ID: <20200419194800.GF11244@42.do-not-panic.com>
References: <20200419194529.4872-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200419194529.4872-1-mcgrof@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

I forgot to mention that I've dropped Reviewed-by tags to patches
I have changed considerably like patch 3/10 which actually fixes
the race. So if you had provided a review before, a new review
would be appreciated.

  Luis
