Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E4ADCDB46E
	for <linux-block@archiver.kernel.org>; Thu, 12 Oct 2023 05:56:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233976AbjJLF43 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 12 Oct 2023 01:56:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232808AbjJLF42 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 12 Oct 2023 01:56:28 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99444A9
        for <linux-block@vger.kernel.org>; Wed, 11 Oct 2023 22:56:26 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id E2C9921871;
        Thu, 12 Oct 2023 05:56:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1697090184; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HHJDGm22mqiO/iV4sBjgTiaTXVPOb65WQ5PQ6cs+hCA=;
        b=Xd2eG+QYyHyWhu7PMhCBUSmHvbi/lwF1JEnQPJX3NS3yDUcOaGnMTgONq8iviaGsFaVfu4
        dVFBagSTRXB0Tb+VuRlcuBkxyE9qS22v2ac7ruP+V5S3ICEWVebRkf1I63p4tHBzpF+w5c
        OA9kEP2senT6HxfRq2NLbwz9r9TMSps=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1697090184;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HHJDGm22mqiO/iV4sBjgTiaTXVPOb65WQ5PQ6cs+hCA=;
        b=zpyoFEs7tHle6tvrLqIASxUkd5DdPAGNSb925PQN7v9rBUeXpP7hhV9UEpYnlAI7+DWgGo
        ZbSpN3ubanorDiCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D436B139F9;
        Thu, 12 Oct 2023 05:56:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id pOF+M4iKJ2WufwAAMHmgww
        (envelope-from <dwagner@suse.de>); Thu, 12 Oct 2023 05:56:24 +0000
Date:   Thu, 12 Oct 2023 07:57:36 +0200
From:   Daniel Wagner <dwagner@suse.de>
To:     Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     linux-block@vger.kernel.org, Yi Zhang <yi.zhang@redhat.com>
Subject: Re: [PATCH blktests 1/2] nvme/{rc,017,031}: replace def_file_path
 with _nvme_def_file_path()
Message-ID: <mxvak5z2k3whlotu3hg7l3thq4z4shgz6dzwbt3qrglpoqrcid@y5rnxf3b7jgi>
References: <20231012021152.832553-1-shinichiro.kawasaki@wdc.com>
 <20231012021152.832553-2-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231012021152.832553-2-shinichiro.kawasaki@wdc.com>
Authentication-Results: smtp-out1.suse.de;
        none
X-Spamd-Result: default: False [-3.60 / 50.00];
         ARC_NA(0.00)[];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         FROM_HAS_DN(0.00)[];
         RCPT_COUNT_THREE(0.00)[3];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         NEURAL_HAM_LONG(-3.00)[-1.000];
         DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
         NEURAL_HAM_SHORT(-1.00)[-1.000];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         MID_RHS_NOT_FQDN(0.50)[];
         RCVD_COUNT_TWO(0.00)[2];
         RCVD_TLS_ALL(0.00)[];
         BAYES_HAM(-0.00)[20.45%]
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Oct 12, 2023 at 11:11:51AM +0900, Shin'ichiro Kawasaki wrote:
> The commit b6356f6 ("nvme/rc: Add common file_path name define") defined
> a global variable 'def_file_path' in nvme/rc, which refers TMPDIR.
> However, when nvme/rc is sourced and def_file_path is defined for the
> nvme test group, TMPDIR is not yet defined since TMPDIR is defined for
> each test case. Then an unexpected path is set to def_file_path and
> temporary files are created at the unexpected path.
> 
> Fix this by replacing the global variable def_file_path with a helper
> function _nvme_def_file_path(). This helper function allows to refer
> TMPDIR not at nvme/rc source timing but in test() or test_device()
> context of each test case.
> 
> Reported-by: Yi Zhang <yi.zhang@redhat.com>
> Fixes: b6356f6 ("nvme/rc: Add common file_path name define")
> Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>

Reviewed-by: Daniel Wagner <dwagern@suse.de>

Thanks,
Daniel
