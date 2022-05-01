Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40A39C433EF
	for <linux-block@archiver.kernel.org>; Sun,  1 May 2022 23:14:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355937AbiEAXSU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 1 May 2022 19:18:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232078AbiEAXSU (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sun, 1 May 2022 19:18:20 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FFAD1400A
        for <linux-block@vger.kernel.org>; Sun,  1 May 2022 16:14:53 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 8616321878;
        Sun,  1 May 2022 23:14:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1651446892; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=jUpPGh6yIvQnw7ZOgmtJ3GX4LJpYD0TEtP6/N39vGnE=;
        b=SZmhAUE5z3aNpckkthjz8yb/DKahgOv0hAB6JU2xUVzX+JGlRzIjwPEUdNIpuArnY3gi+J
        uHyUpTawhXLQvCNJknMv9e4OCdMkSqHLWLTvZgVJ/UjZZDKallTQiqPVNkNXhvoMbW6Q5w
        ZxYa6Cf3oXNvInTqHLj0Ymb+2/4GwvQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1651446892;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=jUpPGh6yIvQnw7ZOgmtJ3GX4LJpYD0TEtP6/N39vGnE=;
        b=d4Ckoj1NfSmKoNtudTx5sSipU4DZyWqccbg1lmLsq2aVB2pNPjFa4MG6SlooqE3gIlz0UB
        S7x3hWuWNaisPoCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 10C9213AE0;
        Sun,  1 May 2022 23:14:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id bvs2KmoUb2KnZwAAMHmgww
        (envelope-from <hare@suse.de>); Sun, 01 May 2022 23:14:50 +0000
Message-ID: <7dca874a-b8ef-59bf-a368-595d0ed2838f@suse.de>
Date:   Mon, 2 May 2022 01:14:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Content-Language: en-US
To:     Omar Sandoval <osandov@fb.com>,
        Christian Brauner <christian.brauner@microsoft.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "lsf-pc@lists.linux-foundation.org" 
        <lsf-pc@lists.linux-foundation.org>
From:   Hannes Reinecke <hare@suse.de>
Subject: [LSF TOPIC] block namespaces
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Omar,

here's a late topic for the I/O Track: Block namespaces

We already proposed it for the (canceled) LSF last year, and now I found 
that Christian Brauner is actually present here at LSF.

What this is about: Similarly to network namespaces we'd like to explore 
the possibility of block namespaces.
Canonical use-case here is iscsi sessions within containers: if one 
container starts up an iscsi session, why should this session be visible 
to the other containers?
The discussion should be about general design and possible use-cases.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
