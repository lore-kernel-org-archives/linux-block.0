Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20F5BC76188
	for <linux-block@archiver.kernel.org>; Wed,  5 Apr 2023 08:18:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237342AbjDEISq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 5 Apr 2023 04:18:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236934AbjDEISp (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 5 Apr 2023 04:18:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCB491BCD
        for <linux-block@vger.kernel.org>; Wed,  5 Apr 2023 01:18:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 685D562484
        for <linux-block@vger.kernel.org>; Wed,  5 Apr 2023 08:18:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00088C433D2;
        Wed,  5 Apr 2023 08:18:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680682723;
        bh=kxqvSmpLYMb7iCIPcteans15yGLvrtJVVUAIseqeY+o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=h+0sZh4kF7dFryyXvX2Y2O0W/x+4TDEKQacY9FiZL9zxnUZLx5EUayBBafafRSXRg
         tvVNyww0NWwHnhD/ZA7NgGb5vchzPSMG2LGDTsDrgNEDPJ8Hwl2PIrZPZmZQiGgQvN
         zTLqcDedI1oXSwiR4V3dfiGIaN7mjny/TMBzZIFUdfzJ+joWqb5QDEREiuEMs1c8p0
         Nk8bEBvMZWjGSfKf5HUF/wWh3Qdq5VJ6iaQc3pJgzLWEddDbA6hxL8b67mYM5KdKlW
         mfOcoffjIZGhxOkoLFab7DH4/0K+NP/U5y+EOafzYw3h9fjdre6DkNBEJiNdd3Atu8
         LP2Ldzse9ApUQ==
Date:   Wed, 5 Apr 2023 10:18:38 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Ondrej Kozina <okozina@redhat.com>
Cc:     linux-block@vger.kernel.org, bluca@debian.org, gmazyland@gmail.com,
        axboe@kernel.dk, hch@infradead.org, jonathan.derrick@linux.dev
Subject: Re: [PATCH 1/5] sed-opal: do not add user authority twice in boolean
 ace.
Message-ID: <20230405-siehst-hielt-b9722ebadae5@brauner>
References: <20230322151604.401680-1-okozina@redhat.com>
 <20230322151604.401680-2-okozina@redhat.com>
 <20230329-amendment-trodden-75a619120b5e@brauner>
 <a2ce079f-f3de-9bf1-5cd0-ec3045a25168@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a2ce079f-f3de-9bf1-5cd0-ec3045a25168@redhat.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Mar 29, 2023 at 05:20:29PM +0200, Ondrej Kozina wrote:
> On 29. 03. 23 16:15, Christian Brauner wrote:
> > On Wed, Mar 22, 2023 at 04:16:00PM +0100, Ondrej Kozina wrote:
> > 
> > This index only appears one time in the code. IOW, you're completely
> > removing OPAL_HALF_UID_BOOLEAN_ACE leavig only
> > OPAL_HALF_UID_AUTHORITY_OBJ_REF. Is that intended and if so why is
> > OPAL_HALF_UID_BOOLEAN_ACE not needed anymore?
> > 
> 
> It seemed redundant when only single authority is added in the set method
> aka { authority1, authority1, OR }:
> 
> TCG Storage Architecture Core Specification, 5.1.3.3 ACE_expression
> 
> "This is an alternative type where the options are either a uidref to an
> Authority object or one of the boolean_ACE (AND = 0 and OR = 1) options.
> This type is used within the AC_element list to form a postfix Boolean
> expression of Authorities."
> 
> I add OPAL_HALF_UID_BOOLEAN_ACE when there's more than single authority
> added in any ACE_expression in later code.

Ok, thanks! As Christoph said, would be good to have this in the commit
message. Otherwise,

Acked-by: Christian Brauner <brauner@kernel.org>
