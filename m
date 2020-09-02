Return-Path: <SRS0=rVNK=CL=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FADDC433E7
	for <linux-block@archiver.kernel.org>; Wed,  2 Sep 2020 22:59:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A36E20767
	for <linux-block@archiver.kernel.org>; Wed,  2 Sep 2020 22:59:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="qgKms+ZI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726400AbgIBW7T (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 2 Sep 2020 18:59:19 -0400
Received: from ale.deltatee.com ([204.191.154.188]:54384 "EHLO
        ale.deltatee.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726310AbgIBW7S (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 2 Sep 2020 18:59:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Sender:
        Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
        :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=quAoXGOZ9TuagLz5yREPtszK1n63wnB3+2Jx8/rWjis=; b=qgKms+ZInyhB9Ygo8ZbF4HUXiB
        IA+kgrwY2x4cGacp69FLnI+xgOoseYz0hvrBakYKjsaVmJCF9YFrPN/wVVK33gD0zzcP6NQPsjcAF
        OuRrIUx878SjtxgcLsWzy6zXH48qgfuakvooZiXD+6wrLqkm9arVYEk6TtwS7W97hIOlG9sTyYOHC
        r3g+V1bFgupd5jjovn7AP5ZO7KWtf0dj8MHdh/TowFG9KnQ2RmYV+AX9gSWMWOAwfB2GVRRuSeVpj
        CPmMLATJP9dc3/dErCDv82IQLkZk/NPTGZ7OS/DzhrsPr1WjFjCeCdQgjy+hjvGYHJsi+DmICy2lf
        98CgejFQ==;
Received: from s01060023bee90a7d.cg.shawcable.net ([24.64.145.4] helo=[192.168.0.10])
        by ale.deltatee.com with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <logang@deltatee.com>)
        id 1kDbil-0002WV-3t; Wed, 02 Sep 2020 16:59:16 -0600
To:     Sagi Grimberg <sagi@grimberg.me>, linux-block@vger.kernel.org,
        Omar Sandoval <osandov@osandov.com>
Cc:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
References: <20200902222901.408217-1-sagi@grimberg.me>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <19fe8876-f821-5c71-4eb5-308d2ddd04f9@deltatee.com>
Date:   Wed, 2 Sep 2020 16:59:14 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200902222901.408217-1-sagi@grimberg.me>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 24.64.145.4
X-SA-Exim-Rcpt-To: Chaitanya.Kulkarni@wdc.com, Johannes.Thumshirn@wdc.com, osandov@osandov.com, linux-block@vger.kernel.org, sagi@grimberg.me
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH v5 0/7] blktests: Add support to run nvme tests with
 tcp/rdma transports
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Sagi,

On 2020-09-02 4:28 p.m., Sagi Grimberg wrote:
> We have a collection of nvme tests, but all run with nvme-loop. This
> is the easiest to run on a standalone machine. However its very much possible
> to run nvme-tcp and nvme-rdma using a loopback network. Add capability to run
> tests with a new environment variable to set the transport type $nvme_trtype.
> 
> $ nvme_trtype=[loop|tcp|rdma] ./check nvme
> 
> This buys us some nice coverage on some more transport types. We also add
> some transport type specific helpers to mark tests that are relevant only
> for a single transport.

I'm still noticing a bunch of quoting issues in your patches. Make sure
you run "make check" on them. I see a lot of warnings introduced by
these (see below).

Logan

--

$ make check
shellcheck -x -e SC2119 -f gcc check new common/* \
	tests/*/rc tests/*/[0-9]*[0-9]
tests/nvme/rc:120:19: note: Double quote to prevent globbing and word
splitting. [SC2086]
tests/nvme/rc:122:21: note: Double quote to prevent globbing and word
splitting. [SC2086]
tests/nvme/rc:134:18: note: Double quote to prevent globbing and word
splitting. [SC2086]
tests/nvme/rc:136:16: note: Double quote to prevent globbing and word
splitting. [SC2086]
tests/nvme/002:25:29: note: Double quote to prevent globbing and word
splitting. [SC2086]
tests/nvme/002:35:17: note: Double quote to prevent globbing and word
splitting. [SC2086]
tests/nvme/003:33:23: note: Double quote to prevent globbing and word
splitting. [SC2086]
tests/nvme/004:26:29: note: Double quote to prevent globbing and word
splitting. [SC2086]
tests/nvme/004:37:23: note: Double quote to prevent globbing and word
splitting. [SC2086]
tests/nvme/005:26:29: note: Double quote to prevent globbing and word
splitting. [SC2086]
tests/nvme/005:37:23: note: Double quote to prevent globbing and word
splitting. [SC2086]
tests/nvme/005:46:24: note: Double quote to prevent globbing and word
splitting. [SC2086]
tests/nvme/006:33:29: note: Double quote to prevent globbing and word
splitting. [SC2086]
tests/nvme/007:32:29: note: Double quote to prevent globbing and word
splitting. [SC2086]
tests/nvme/008:35:29: note: Double quote to prevent globbing and word
splitting. [SC2086]
tests/nvme/008:38:23: note: Double quote to prevent globbing and word
splitting. [SC2086]
tests/nvme/009:31:29: note: Double quote to prevent globbing and word
splitting. [SC2086]
tests/nvme/009:34:23: note: Double quote to prevent globbing and word
splitting. [SC2086]
tests/nvme/010:35:29: note: Double quote to prevent globbing and word
splitting. [SC2086]
tests/nvme/010:38:23: note: Double quote to prevent globbing and word
splitting. [SC2086]
tests/nvme/011:33:29: note: Double quote to prevent globbing and word
splitting. [SC2086]
tests/nvme/011:36:23: note: Double quote to prevent globbing and word
splitting. [SC2086]
tests/nvme/012:39:29: note: Double quote to prevent globbing and word
splitting. [SC2086]
tests/nvme/012:42:23: note: Double quote to prevent globbing and word
splitting. [SC2086]
tests/nvme/013:36:29: note: Double quote to prevent globbing and word
splitting. [SC2086]
tests/nvme/013:39:23: note: Double quote to prevent globbing and word
splitting. [SC2086]
tests/nvme/014:35:29: note: Double quote to prevent globbing and word
splitting. [SC2086]
tests/nvme/014:38:23: note: Double quote to prevent globbing and word
splitting. [SC2086]
tests/nvme/015:32:29: note: Double quote to prevent globbing and word
splitting. [SC2086]
tests/nvme/015:35:23: note: Double quote to prevent globbing and word
splitting. [SC2086]
tests/nvme/016:34:29: note: Double quote to prevent globbing and word
splitting. [SC2086]
tests/nvme/017:37:29: note: Double quote to prevent globbing and word
splitting. [SC2086]
tests/nvme/018:33:29: note: Double quote to prevent globbing and word
splitting. [SC2086]
tests/nvme/018:36:23: note: Double quote to prevent globbing and word
splitting. [SC2086]
tests/nvme/019:37:29: note: Double quote to prevent globbing and word
splitting. [SC2086]
tests/nvme/019:40:23: note: Double quote to prevent globbing and word
splitting. [SC2086]
tests/nvme/020:33:29: note: Double quote to prevent globbing and word
splitting. [SC2086]
tests/nvme/020:36:23: note: Double quote to prevent globbing and word
splitting. [SC2086]
tests/nvme/021:32:29: note: Double quote to prevent globbing and word
splitting. [SC2086]
tests/nvme/021:35:23: note: Double quote to prevent globbing and word
splitting. [SC2086]
tests/nvme/022:32:29: note: Double quote to prevent globbing and word
splitting. [SC2086]
tests/nvme/022:35:23: note: Double quote to prevent globbing and word
splitting. [SC2086]
tests/nvme/023:35:29: note: Double quote to prevent globbing and word
splitting. [SC2086]
tests/nvme/023:38:23: note: Double quote to prevent globbing and word
splitting. [SC2086]
tests/nvme/024:32:29: note: Double quote to prevent globbing and word
splitting. [SC2086]
tests/nvme/024:35:23: note: Double quote to prevent globbing and word
splitting. [SC2086]
tests/nvme/025:32:29: note: Double quote to prevent globbing and word
splitting. [SC2086]
tests/nvme/025:35:23: note: Double quote to prevent globbing and word
splitting. [SC2086]
tests/nvme/026:32:29: note: Double quote to prevent globbing and word
splitting. [SC2086]
tests/nvme/026:35:23: note: Double quote to prevent globbing and word
splitting. [SC2086]
tests/nvme/027:32:29: note: Double quote to prevent globbing and word
splitting. [SC2086]
tests/nvme/027:35:23: note: Double quote to prevent globbing and word
splitting. [SC2086]
tests/nvme/028:32:29: note: Double quote to prevent globbing and word
splitting. [SC2086]
tests/nvme/028:35:23: note: Double quote to prevent globbing and word
splitting. [SC2086]
tests/nvme/028:41:46: note: Double quote to prevent globbing and word
splitting. [SC2086]
tests/nvme/029:68:29: note: Double quote to prevent globbing and word
splitting. [SC2086]
tests/nvme/029:71:23: note: Double quote to prevent globbing and word
splitting. [SC2086]
tests/nvme/030:41:29: note: Double quote to prevent globbing and word
splitting. [SC2086]
tests/nvme/031:40:29: note: Double quote to prevent globbing and word
splitting. [SC2086]
tests/nvme/031:45:24: note: Double quote to prevent globbing and word
splitting. [SC2086]
