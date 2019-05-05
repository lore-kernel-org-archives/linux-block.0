Return-Path: <SRS0=gQfC=TF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E792C004C9
	for <linux-block@archiver.kernel.org>; Sun,  5 May 2019 19:13:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BC01208C0
	for <linux-block@archiver.kernel.org>; Sun,  5 May 2019 19:13:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557083581;
	bh=vFRleH5x3XYIjIaPO4Mdt89X8FFdmsfdaCjM+ZfIqLo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=mz2jlM74ZX4t3ny8rxy+O7csUlkMbTiKbq20obJYP4ZwRYtbtOxVggERxAYzGt42x
	 jag8sp2Wegvv98i+PPXnua4wkZbdHoZ25Pk8zT/CguhJTIW0kSkEjp6rPo/cegLHES
	 dWh7IBd1LGBEvgN+bkpvBD3IDu7eNqaTo1aloQus=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727749AbfEETNA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 5 May 2019 15:13:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:33916 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726636AbfEETNA (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sun, 5 May 2019 15:13:00 -0400
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 381AC206DF;
        Sun,  5 May 2019 19:12:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557083579;
        bh=vFRleH5x3XYIjIaPO4Mdt89X8FFdmsfdaCjM+ZfIqLo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kFTP1rZGukRBFgJTmJg4OBBHtq9UuvpfpWszjrmZyEUqsQGiJNtapxDFs94sWPUHS
         CyOoAMbcMgWppgcu1SF+7XgwqTcASCOoPMMoONcPTBbmsmEEEcpeWYX26QGj9vj3ef
         +6ACtal3eByCJwnZfCJBZ8VMTmMD+rh1+fIFEKMk=
Date:   Sun, 5 May 2019 15:12:58 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Roger Pau Monne <roger.pau@citrix.com>
Cc:     linux-kernel@vger.kernel.org,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Jens Axboe <axboe@kernel.dk>, xen-devel@lists.xenproject.org,
        linux-block@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] xen-blkfront: switch kcalloc to kvcalloc for large array
 allocation
Message-ID: <20190505191258.GB1747@sasha-vm>
References: <20190503150401.15904-1-roger.pau@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190503150401.15904-1-roger.pau@citrix.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, May 03, 2019 at 05:04:01PM +0200, Roger Pau Monne wrote:
>There's no reason to request physically contiguous memory for those
>allocations.
>
>Reported-by: Ian Jackson <ian.jackson@citrix.com>
>Signed-off-by: Roger Pau Monné <roger.pau@citrix.com>
>---

You really don't want this scissor line here, git will trim all your
message content below it.

--
Thanks,
Sasha

>Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
>Cc: Juergen Gross <jgross@suse.com>
>Cc: Stefano Stabellini <sstabellini@kernel.org>
>Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
>Cc: Jens Axboe <axboe@kernel.dk>
>Cc: xen-devel@lists.xenproject.org
>Cc: linux-block@vger.kernel.org
>Cc: stable@vger.kernel.org
>---
