Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BC0FC433E0
	for <linux-block@archiver.kernel.org>; Wed, 10 Feb 2021 03:39:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CBF8264DEE
	for <linux-block@archiver.kernel.org>; Wed, 10 Feb 2021 03:39:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229584AbhBJDir (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 9 Feb 2021 22:38:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:46882 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229464AbhBJDiq (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 9 Feb 2021 22:38:46 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 94AE16146D;
        Wed, 10 Feb 2021 03:38:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612928285;
        bh=omuswNr75IfEADV8hRxzWRhLCQdRwzy/+d1/OpWn4CY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IFGKOKNJUV5n9llW6YtIQZyuq/UAy/AhA4NMLNTfNw7eyUhOVEIuUgiBEIY4HA/1J
         CO1FdfUc8GCujMAEIlLAYe+dYmcm8iNBkilswJqBRDUhSHECY4Srks4d3//ZgJAHeJ
         /wnGjQIMwtu5LuuhwS+QKGbjSOLcRVw3dnhnazGjAgEW7Y1TZJFb+yaC9X/Ixoe0Jh
         34sVtx9JODJHJPDWRGulX1LA4esMOkNmSLvSNZ2M8NCIUAA4Cxl/vo4HZBO6UdIJPd
         OMxDHW+dv8NCj4aCFA680LKgTgmYz3NhGE1ZN0AWmhA6rPpUpsUE4r8g3te5R1By4E
         X/Pqyu5tgEn5A==
Date:   Wed, 10 Feb 2021 12:38:02 +0900
From:   Keith Busch <kbusch@kernel.org>
To:     Yi Zhang <yi.zhang@redhat.com>
Cc:     Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
        linux-block <linux-block@vger.kernel.org>, axboe@kernel.dk,
        Rachel Sibley <rasibley@redhat.com>,
        Chaitanya.Kulkarni@wdc.com, CKI Project <cki-project@redhat.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: Re: kernel null pointer at nvme_tcp_init_iter+0x7d/0xd0 [nvme_tcp]
Message-ID: <20210210033802.GA23363@redsun51.ssa.fujisawa.hgst.com>
References: <cki.F3E139361A.EN5MUSJKK9@redhat.com>
 <630237787.11660686.1612580898410.JavaMail.zimbra@redhat.com>
 <e1d08160-ca49-91e2-dafc-3ee80516842d@grimberg.me>
 <5848858e-239d-acb2-fa24-c371a3360557@redhat.com>
 <a88fd4c8-8d5c-6934-39bc-5c864e3ed84f@grimberg.me>
 <aec13f12-640c-77d5-bbdd-b4a3e18f1bf2@redhat.com>
 <6ae16841-5f51-617a-aab7-666b7eed299c@grimberg.me>
 <1a520912-ac7c-1a3c-c432-b382a5da6177@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1a520912-ac7c-1a3c-c432-b382a5da6177@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Feb 10, 2021 at 10:51:56AM +0800, Yi Zhang wrote:
> On 2/10/21 2:01 AM, Sagi Grimberg wrote:
> So it's nvme_admin_abort_cmd here

The opcode 8 would be abort if this were an admin command, but we can't
tell that from the nvme print. The subsequent blk_update_request log
indicates this is the IO command for a Write Zeroes operation.
 
> [   75.235059] nvme_tcp: rq 38 opcode 8
> [   75.238653] blk_update_request: I/O error, dev nvme0c0n1, sector 1048624 op 0x9:(WRITE_ZEROES) flags 0x2800800 phys_seg 0 prio class 0
