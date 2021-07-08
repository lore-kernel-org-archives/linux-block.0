Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB299C07E96
	for <linux-block@archiver.kernel.org>; Thu,  8 Jul 2021 12:43:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 84DF561432
	for <linux-block@archiver.kernel.org>; Thu,  8 Jul 2021 12:43:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231404AbhGHMqg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 8 Jul 2021 08:46:36 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:41564 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbhGHMqg (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 8 Jul 2021 08:46:36 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 6F37421910;
        Thu,  8 Jul 2021 12:43:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1625748233; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=FPMlgO+Zfo14oN0BcwYJE0QxFqpC+nPj8IpTkd710H4=;
        b=LtDxVYxw8NSplGmzVQW3iV1asSAQcG2u79ScBvLOfTA9AgcT0W5CJNKY8AWeRfznZYMjT6
        SJ93ktysNftCsUW3OTocLzu2Uh1Of6+hkDdUxPfzvMSSZ85RwzA6H7WwToYc19I52HWrN1
        BkIRL0rzWzk+5sk2hSRdeD7Td/wtZzk=
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 2FEE912FF6;
        Thu,  8 Jul 2021 12:43:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id QiFxCgnz5mCCYAAAGKfGzw
        (envelope-from <jgross@suse.com>); Thu, 08 Jul 2021 12:43:53 +0000
From:   Juergen Gross <jgross@suse.com>
To:     xen-devel@lists.xenproject.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        =?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger.pau@citrix.com>,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH v2 0/3] xen: harden blkfront against malicious backends
Date:   Thu,  8 Jul 2021 14:43:42 +0200
Message-Id: <20210708124345.10173-1-jgross@suse.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Xen backends of para-virtualized devices can live in dom0 kernel, dom0
user land, or in a driver domain. This means that a backend might
reside in a less trusted environment than the Xen core components, so
a backend should not be able to do harm to a Xen guest (it can still
mess up I/O data, but it shouldn't be able to e.g. crash a guest by
other means or cause a privilege escalation in the guest).

Unfortunately blkfront in the Linux kernel is fully trusting its
backend. This series is fixing blkfront in this regard.

It was discussed to handle this as a security problem, but the topic
was discussed in public before, so it isn't a real secret.

Changes in V2:
- put blkfront patches into own series
- some minor comments addressed

Juergen Gross (3):
  xen/blkfront: read response from backend only once
  xen/blkfront: don't take local copy of a request from the ring page
  xen/blkfront: don't trust the backend response data blindly

 drivers/block/xen-blkfront.c | 122 +++++++++++++++++++++++------------
 1 file changed, 80 insertions(+), 42 deletions(-)

-- 
2.26.2

