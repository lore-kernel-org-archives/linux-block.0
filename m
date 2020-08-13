Return-Path: <SRS0=n79e=BX=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CFD6C433DF
	for <linux-block@archiver.kernel.org>; Thu, 13 Aug 2020 11:02:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 11D0620866
	for <linux-block@archiver.kernel.org>; Thu, 13 Aug 2020 11:02:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QKUjbtJA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726249AbgHMLCJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 13 Aug 2020 07:02:09 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:23261 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726072AbgHMLCI (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 13 Aug 2020 07:02:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597316526;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nwL7q1BwwvotEeVmc+CSbaiUfly+O7IY6Ee0/xsv+Z4=;
        b=QKUjbtJAhdEx7EbvVNggw0WCFLnSMfkgGdCQndWB9Onzm8DLXShAcT7shUevSmnJsm6CDi
        /geoGYCTN3WYAaTa5m7Qub1DFg/2y79g74OBawnvq/IN8cICUz42g4gYY65kfzz2AyKYNR
        o3N0bcq8BQakbO+tV1UoKhjdpt31R7Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-416-zhypoalJOp6vop8aM4OiVg-1; Thu, 13 Aug 2020 07:02:03 -0400
X-MC-Unique: zhypoalJOp6vop8aM4OiVg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1506F801AAC;
        Thu, 13 Aug 2020 11:02:02 +0000 (UTC)
Received: from localhost.localdomain (ovpn-12-61.pek2.redhat.com [10.72.12.61])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5C24F5C1A3;
        Thu, 13 Aug 2020 11:01:58 +0000 (UTC)
Subject: Re: [PATCH v3 0/7] blktests: Add support to run nvme tests with
 tcp/rdma transports
To:     Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, Omar Sandoval <osandov@osandov.com>
Cc:     Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>
References: <20200811210102.194287-1-sagi@grimberg.me>
From:   Yi Zhang <yi.zhang@redhat.com>
Message-ID: <716a47aa-dd94-d503-80c9-6c31260de31c@redhat.com>
Date:   Thu, 13 Aug 2020 19:01:54 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200811210102.194287-1-sagi@grimberg.me>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 8/12/20 5:00 AM, Sagi Grimberg wrote:
> We have a collection of nvme tests, but all run with nvme-loop. This
> is the easiest to run on a standalone machine. However its very much possible
> to run nvme-tcp and nvme-rdma using a loopback network. Add capability to run
> tests with a new environment variable to set the transport type $nvme_trtype.
>
> $ nvme_trtype=[loop|tcp|rdma] ./check test/nvme
The executing cmd should be:
$ nvme_trtype=[loop|tcp|rdma] ./check nvme

Also described in
[PATCH v3 5/7] nvme: support nvme-tcp when runinng tests

> This buys us some nice coverage on some more transport types. We also add
> some transport type specific helpers to mark tests that are relevant only
> for a single transport.
>
> Changes from v2:
> - changed patch 6 to move unload_module to common/rc
> - changed helper to be named _require_nvme_trtype_is_fabrics
> Changes from v1:
> - added patch to remove use of module_unload
> - move trtype agnostic logig helpers in patch #3
>
> Sagi Grimberg (7):
>    nvme: consolidate nvme requirements based on transport type
>    nvme: consolidate some nvme-cli utility functions
>    nvme: make tests transport type agnostic
>    tests/nvme: restrict tests to specific transports
>    nvme: support nvme-tcp when runinng tests
>    common: move module_unload to common
>    nvme: support rdma transport type
>
>   common/rc          |  13 +++++
>   tests/nvme/002     |   8 +--
>   tests/nvme/003     |  10 ++--
>   tests/nvme/004     |  12 +++--
>   tests/nvme/005     |  15 +++---
>   tests/nvme/006     |   7 +--
>   tests/nvme/007     |   5 +-
>   tests/nvme/008     |  13 ++---
>   tests/nvme/009     |  11 ++--
>   tests/nvme/010     |  13 ++---
>   tests/nvme/011     |  13 ++---
>   tests/nvme/012     |  14 +++---
>   tests/nvme/013     |  13 ++---
>   tests/nvme/014     |  13 ++---
>   tests/nvme/015     |  12 +++--
>   tests/nvme/016     |   7 +--
>   tests/nvme/017     |   7 +--
>   tests/nvme/018     |  13 ++---
>   tests/nvme/019     |  13 ++---
>   tests/nvme/020     |  11 ++--
>   tests/nvme/021     |  13 ++---
>   tests/nvme/022     |  13 ++---
>   tests/nvme/023     |  13 ++---
>   tests/nvme/024     |  13 ++---
>   tests/nvme/025     |  13 ++---
>   tests/nvme/026     |  13 ++---
>   tests/nvme/027     |  13 ++---
>   tests/nvme/028     |  15 +++---
>   tests/nvme/029     |  13 ++---
>   tests/nvme/030     |   8 +--
>   tests/nvme/031     |  12 ++---
>   tests/nvme/032     |   4 ++
>   tests/nvme/rc      | 122 ++++++++++++++++++++++++++++++++++++++++++---
>   tests/nvmeof-mp/rc |  13 -----
>   34 files changed, 322 insertions(+), 179 deletions(-)
>

