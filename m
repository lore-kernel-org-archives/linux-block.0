Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42F2CC7EE29
	for <linux-block@archiver.kernel.org>; Fri,  9 Jun 2023 15:48:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241884AbjFIPsr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 9 Jun 2023 11:48:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241886AbjFIPsm (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 9 Jun 2023 11:48:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 506A635A7;
        Fri,  9 Jun 2023 08:48:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CFA8161137;
        Fri,  9 Jun 2023 15:48:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC1C2C433EF;
        Fri,  9 Jun 2023 15:48:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686325718;
        bh=WX6Q3krLeXnyU1ErGKnaGEj0J5rvRDqnfROl5WFYUIc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rXToGuuBjfpmadxzXsA3qNSs9Uctw/JjB3k4BOeQ1ePcRbZDIZrMFXgjk0FLI5+6N
         xLXzs+TlhVRxgpXkok6zOvszXWTi0iZ0XajKxqnuPlijuRWuziKlezMR4q+yRTdiMM
         88F1Pd2w/QBnYigXElc7Kb66IzSEfjEuCdozLtmQJkGWqzI3dqU2+k/KBBUOjuNL1n
         Lv5h0GyXn81iJlVnAcDq2ikylVnzy3lzrvCXOXZYhrZP+1696l/tXwV9hf0QA9QwWK
         CwLAWydyCUDVB0CmGTq0PzfggYlK9h4uf+myx0dm9X+kd1JQLURB8QpTYOTl6FYYQQ
         wehKAaEZ+oLbA==
Date:   Fri, 9 Jun 2023 09:48:35 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Daniel Wagner <dwagner@suse.de>
Cc:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, Chaitanya Kulkarni <kch@nvidia.com>,
        Shin'ichiro Kawasaki <shinichiro@fastmail.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH v4 1/1] nvmet-fcloop: Do not wait on completion when
 unregister fails
Message-ID: <ZINJ03uCTFyRItpw@kbusch-mbp>
References: <20230606122411.7972-1-dwagner@suse.de>
 <20230606122411.7972-2-dwagner@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230606122411.7972-2-dwagner@suse.de>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Thanks, applied for nvme-6.5.
