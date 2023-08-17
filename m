Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3A8BEB64DD
	for <linux-block@archiver.kernel.org>; Thu, 17 Aug 2023 08:19:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348801AbjHQISu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 17 Aug 2023 04:18:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348825AbjHQISg (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 17 Aug 2023 04:18:36 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20E812722
        for <linux-block@vger.kernel.org>; Thu, 17 Aug 2023 01:18:35 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id D8F4D1F895;
        Thu, 17 Aug 2023 08:18:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1692260313; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gtHPjUmwaHRpLRWbT3zdN8f2jVVD5Hmnt8RivMUM4u4=;
        b=ILPYFCsOs1ZNRiC15Yy34zYLdObs3aR3OmdTkgzNNV/VU8Yy1XgXg9Tlh6v59fJw7cg1h1
        rQOwX9YKbSq1FC3yRMepTyiBwdwCRKBwI0UfR7Q55TkStHhevcRTv1UAJb4+o2fKKw1JkG
        TftewAJnQVPgN8+TZZ3iqNnhByZWDrI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1692260313;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gtHPjUmwaHRpLRWbT3zdN8f2jVVD5Hmnt8RivMUM4u4=;
        b=i+vIbgC5hsYenW6Emdorro3G8ruAfTrMJO5gSBeU2vvcSoHCCSJekJt5ZaZTcd2oibBo4/
        GC4QBLLFQn5cfJAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C456C1392B;
        Thu, 17 Aug 2023 08:18:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id NgF3LtnX3WQMUQAAMHmgww
        (envelope-from <dwagner@suse.de>); Thu, 17 Aug 2023 08:18:33 +0000
Date:   Thu, 17 Aug 2023 10:18:43 +0200
From:   Daniel Wagner <dwagner@suse.de>
To:     Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        Yi Zhang <yi.zhang@redhat.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH blktests v2 2/2] nvme: remove "udevadm settle" after
 _nvme_connect_subsys
Message-ID: <cplbxtua73zfpotuqrjthmwoziqpfjtolfpimk2z4rml437muk@x37qkkvc6twt>
References: <20230817073021.3674602-1-shinichiro.kawasaki@wdc.com>
 <20230817073021.3674602-2-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230817073021.3674602-2-shinichiro.kawasaki@wdc.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Aug 17, 2023 at 04:30:21PM +0900, Shin'ichiro Kawasaki wrote:
> The previous commit introduced "udevadm settle" command at the end of
> _nvme_connect_subsys. Then the command is no longer required after
> calling _nvme_connect_subsys in test cases.
> 
> Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>

Reviewed-by: Daniel Wagner <dwagner@suse.de>
