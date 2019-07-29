Return-Path: <SRS0=KgRV=V2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1A1FC433FF
	for <linux-block@archiver.kernel.org>; Mon, 29 Jul 2019 17:31:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 740E8204EC
	for <linux-block@archiver.kernel.org>; Mon, 29 Jul 2019 17:31:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=osandov-com.20150623.gappssmtp.com header.i=@osandov-com.20150623.gappssmtp.com header.b="pqvS3I5S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727454AbfG2RbX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 29 Jul 2019 13:31:23 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:33582 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727202AbfG2RbW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 29 Jul 2019 13:31:22 -0400
Received: by mail-pg1-f196.google.com with SMTP id f20so19370672pgj.0
        for <linux-block@vger.kernel.org>; Mon, 29 Jul 2019 10:31:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XTU4jRerq/5+h399trMmv4Ll69fbgOnjk4FnYnMBLQs=;
        b=pqvS3I5S/MUYoz0vTEsWXVc8IXND5rbU8xNP8RmeWxMxf1asxg7XhLhw4edcO+7dyp
         0uuIu74WXpYdZz47CevQ8XihOIhX4T3f4fUeSl9HUAPA7PKPXHN/bPig8eJQLuLmiwkp
         B40RptpRr3vVg+TrIto1ynNyhWwiejqRGx2FCRB7m8iuKMcrEGYJ2j8+LDaQmnpi75TH
         O+fHcm69+HmU/z3ETD2BKkJ5HWTv441osdWESjqk19ng3JF+vc9P5GX+NrE6cqvjmiHq
         uhIULj6hkGezgMgkXmGqPFIH0CVVo4qSB2EEtKDo0lStEf6cadMXPYsttCM3LbW8/zdw
         Wt0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XTU4jRerq/5+h399trMmv4Ll69fbgOnjk4FnYnMBLQs=;
        b=a7s4nNs5iFY6jLPn/c5Ap10ZfoF7rD4LOSsSRK1psb27tFDQPYvpehwBFxG75KCWT4
         XTQx3kes0lDBpmGLYuhHyvnive54eoM2TKV1jw4mh6vspoy2pe5F9SeTE4inYIBtG7j+
         5wjW8fU9Ah0oqBQaG0W4YmkWb3vZiGcJUwEtZDNg8M+jxUNPlKcEp5UmtBs52qGO0WdY
         0oAGz39N5zDsFaYqodRGRKZJH+6ns3V3gOcUVHAb+34zF/7YOZxlP+t0i8nzXs1ZIigW
         qm/Cs9biGn2qGb7N61eCTwtLbaPWWVHVQ4Lft9hS/CdLeT1a/GgE/MS8+qxUXPH0B4FW
         1zqQ==
X-Gm-Message-State: APjAAAV6TFnnw2lGwvpIg+MidQGlwAJKqH0XxCpOrzt4MXy9P0bmy00J
        CMMI10HHc/EWIHd56njOKfpyFA==
X-Google-Smtp-Source: APXvYqwUYO8gIkuJjYG6aVYcHXZCkrMyfGst33ED4xkIj6h5fh3FaJRupbt0Pk7bS31IgT5IEDY3ow==
X-Received: by 2002:a17:90a:ab01:: with SMTP id m1mr26024965pjq.69.1564421481711;
        Mon, 29 Jul 2019 10:31:21 -0700 (PDT)
Received: from vader ([2620:10d:c090:200::6d3])
        by smtp.gmail.com with ESMTPSA id p187sm95012485pfg.89.2019.07.29.10.31.20
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 29 Jul 2019 10:31:20 -0700 (PDT)
Date:   Mon, 29 Jul 2019 10:31:19 -0700
From:   Omar Sandoval <osandov@osandov.com>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        Omar Sandoval <osandov@fb.com>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        Michael Moese <mmoese@suse.de>, Theodore Ts'o <tytso@mit.edu>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Stephen Bates <sbates@raithlin.com>
Subject: Re: [PATCH blktests v2 00/12] Fix nvme block test issues
Message-ID: <20190729173119.GA30186@vader>
References: <20190717171259.3311-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190717171259.3311-1-logang@deltatee.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jul 17, 2019 at 11:12:47AM -0600, Logan Gunthorpe wrote:
> Changes since v1:
>  * Use second sed expression instead of another call to grep
>    in _filter_discovery() for Patch 2 (per Omar)
>  * Redirect error output to $FULL in for nvme/018 in Patch 7
>    (Per Johannes)
>  * Rework _have_module_param() in Patch 11 so that it supports
>    cases where the module is not inserted.
> 
> --
> 
> This patchset cleans up a number of issues and pain points
> I've had with getting the nvme blktests to pass and run cleanly.
> 
> The first three patches are meant to fix the Generation Counter
> issue that's been discussed before but hasn't been fixed in months.
> I primarily use a slightly fixed up patch posted by Michael Moese[1]
> but add another patch to properly test the Generation Counter that
> would no longer be tested otherwise.
> 
> I've also taken it a step further to filter out more of the discovery
> information so that we are less fragile against churn and less dependant
> on the version of nvme-cli in use. This should also fix the issue discussed
> in [2].
> 
> Patches 4 through 7 fix a number of smaller issues I've found with
> individual tests.
> 
> Patches 8 through 10 implement a system to ensure the nvme tests
> clean themselves up properly especially when ctrl-c is used to
> interrupt a test (working with the tests before this was a huge
> pain seeing,  when you ctrl-c, you have to either manually clean
> up the nvmet configuration or reboot to get the system in a state
> where it's sane to run the tests again).
> 
> Patches 11 and 12 make some minor changes that allow running the
> tests with the nvme modules built into the kernel.
> 
> With these patches, plus a couple I've sent to the nvme list for the
> kernel, I can consistently pass the entire nvme suite with the
> exception of the lockdep false-positive with nvme/012 that still
> seems to be in a bit of contention[3].
> 
> [1] https://github.com/osandov/blktests/pull/34
> [2] https://lore.kernel.org/linux-block/20190505150611.15776-4-minwoo.im.dev@gmail.com/
> [3] https://lore.kernel.org/lkml/20190214230058.196511-22-bvanassche@acm.org/

Merged, thanks, Logan!
