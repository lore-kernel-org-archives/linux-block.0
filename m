Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D63D8C7EE2E
	for <linux-block@archiver.kernel.org>; Fri, 21 Apr 2023 06:12:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232030AbjDUGIv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 21 Apr 2023 02:08:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230155AbjDUGIu (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 21 Apr 2023 02:08:50 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B64BD2107;
        Thu, 20 Apr 2023 23:08:05 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 2D0B0219FF;
        Fri, 21 Apr 2023 05:59:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1682056790; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dhdeIsytLIVjWf6yjF5V1uEm0pNge/YpOD8xlqvmOG8=;
        b=vVroTMaRT43s6Q48bBkb3eZErXKAjHDMwT8ic9xX0HrKrF2rti7W2NwqNdbICvdnDL1luS
        kIqhsfb8U2yWh+qbpDrkC3/oK96sIXAsARupulM5CjH4h/e3QcULDUKhtia5JcRtxW5jqN
        8nSgNlSZt6joacINvDlQELSSD+KtBTs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1682056790;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dhdeIsytLIVjWf6yjF5V1uEm0pNge/YpOD8xlqvmOG8=;
        b=NFwGXqrlJWSjLhwvVuSoOG6xQNqXb/YVgVs2uYdl2eIdUbTra5bKSoO8xSxbogsMTNXwAZ
        PZUwjya+4q+QFHCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 169701390E;
        Fri, 21 Apr 2023 05:59:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id tgbqBFYmQmTcYwAAMHmgww
        (envelope-from <dwagner@suse.de>); Fri, 21 Apr 2023 05:59:50 +0000
Date:   Fri, 21 Apr 2023 07:59:49 +0200
From:   Daniel Wagner <dwagner@suse.de>
To:     linux-nvme@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Shin'ichiro Kawasaki <shinichiro@fastmail.com>
Subject: Re: [PATCH blktests v2 0/9] nvme testsuite runtime optimization
Message-ID: <7hwnfsbib4orqekljbll4hejijzjtzfr65trqygiffycbuy5be@6fd6jbkifbpo>
References: <20230420183121.4489-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230420183121.4489-1-dwagner@suse.de>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Screwed up with the mailing process. This series contains an early version of
v2. Let me repost the correct version.
