Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 252D5C4167B
	for <linux-block@archiver.kernel.org>; Wed, 21 Dec 2022 00:32:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229451AbiLUAcf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 20 Dec 2022 19:32:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbiLUAce (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 20 Dec 2022 19:32:34 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DAA31DF02
        for <linux-block@vger.kernel.org>; Tue, 20 Dec 2022 16:32:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=eByFfAtLuCLolQcQ8YHG/CKOC1Nc2tLMD6JtTNxEa7g=; b=AWyqKANgleLH9tN3tjF9/VTYBx
        lMHaBi1W3ZivgVWrOcQKRJp9IlWptj9JtYlaSCfrF0GgUv3Bhbg94m0VcUW72XrzMAAaPUVkmp9Rh
        u9Kq7+K09uzTfMzeHWQUs3A/kErx0/+1vUcS7IPwMOVN6DsJxXo+vnilSSj8Ua++lY0r5beSGhngJ
        fds7yUTUijFU4lcn0itCfG2Cfj1J+5txa3S2uIr4a/64SBCjRRJ+0vC+z7sBL0EEpe/J7oOoRh6Ep
        P92vvGDzZYSTOT849xEkZZk/U2BLvqAlE00dQNFilm0f1vgoaRyWHwtJ6hXH+VqD6YSOmjiUI2H7H
        q3vMNlgQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p7n27-006RIX-6q; Wed, 21 Dec 2022 00:32:31 +0000
Date:   Tue, 20 Dec 2022 16:32:31 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     osandov@fb.com, bvanassche@acm.org
Cc:     kch@nvidia.com, linux-block@vger.kernel.org
Subject: Re: [PATCH v3 1/2] blktests: replace module removal with patient
 module removal
Message-ID: <Y6JUH0FMuMkpV1lt@bombadil.infradead.org>
References: <20221220235324.1445248-1-mcgrof@kernel.org>
 <20221220235324.1445248-2-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221220235324.1445248-2-mcgrof@kernel.org>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

>  common/rc                  | 134 +++++++++++++++++++++++++++++++++++++

Rats, I spotted just two more typos while doing the update to the
fstests code, if you can fold these changes in to this patch, it would
be great.

  Luis

diff --git a/common/rc b/common/rc
index b17fcbf70c6d..c8890f6a4193 100644
--- a/common/rc
+++ b/common/rc
@@ -465,7 +465,7 @@ _patient_rmmod_check_refcnt()
 # This applies to both cases where kmod supports the patient module remover
 # (modrobe --wait) and where it does not.
 #
-# If your version of kmod supports modprobe -p, we instead use that
+# If your version of kmod supports modprobe --wait, we instead use that
 # instead. Otherwise we have to implement a patient module remover
 # ourselves.
 _patient_rmmod()
@@ -524,7 +524,7 @@ _patient_rmmod()
 	# https://bugzilla.kernel.org/show_bug.cgi?id=212337
 	# https://bugzilla.kernel.org/show_bug.cgi?id=214015
 	while [[ $max_tries != 0 ]]; do
-		if [[ -d /sys/module/$module ]]; then
+		if [[ -d /sys/module/$module_sys ]]; then
 			modprobe -r "$module" 2> /dev/null
 			mod_ret=$?
 			if [[ $mod_ret == 0 ]]; then
