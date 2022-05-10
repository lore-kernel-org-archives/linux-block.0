Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 984E9C433F5
	for <linux-block@archiver.kernel.org>; Tue, 10 May 2022 14:42:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243820AbiEJOng (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 10 May 2022 10:43:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345735AbiEJOmI (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 10 May 2022 10:42:08 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 427482DE5BE;
        Tue, 10 May 2022 06:59:01 -0700 (PDT)
Received: from cwcc.thunk.org (pool-108-7-220-252.bstnma.fios.verizon.net [108.7.220.252])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 24ADwqEm019007
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 10 May 2022 09:58:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1652191134; bh=ELoeyyjbombVQLJQDZ90fy5JEa7g8ixVorTda9Hrh50=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=GUAtY4+MHN5s05b7akjhKsd5kU6mIDEZGVmOORprQbxynWLgSSakFl0Mj9sxdUEBE
         vBAYn7bQHmhrWOdYksP746q+rVUW9/MnRSD4hi+B+/6lc84mvEKjZWoYoBildIkSJK
         F8hJFMkucCdv8wHecFW1MqjbZV+IoM0aU0pK7EcwFdK7yGgVJ0UrP3WZkzjPk6QiRP
         3+wW+1P2ZxXbgy7aMFrslRdme7nD4+/nEvUoErJUOLJ6f4oAj6hS1xu4RzYBoYMmol
         K4NwW3tC/oK9kaB68rJ7KWy3ikbnWeisIdCCczfh/V6ZuOYN6zxz9aJYRJmJt4UOCo
         qD5j2m9V1Dw4A==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 94B3015C3F0A; Tue, 10 May 2022 09:58:52 -0400 (EDT)
Date:   Tue, 10 May 2022 09:58:52 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org,
        linux-spdx@vger.kernel.org
Subject: Re: SPDX tag and top of file comment cleanups for the loop driver
Message-ID: <YnpvnMk+1jd7fq0z@mit.edu>
References: <20220419063303.583106-1-hch@lst.de>
 <YnGLRAuS8QGaSADK@mit.edu>
 <20220503201334.GA7325@lst.de>
 <YnGgP7ubsXxFTaZE@mit.edu>
 <20220510072243.GB11929@lst.de>
 <c393d0dd-05a9-2a12-92a2-eebd8d49c2dd@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c393d0dd-05a9-2a12-92a2-eebd8d49c2dd@kernel.dk>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, May 10, 2022 at 06:29:52AM -0600, Jens Axboe wrote:
> On 5/10/22 1:22 AM, Christoph Hellwig wrote:
> > Jens,
> > 
> > are the comments from Ted here enough to apply the series?  Or do
> > we need a formal Acked-by to be on the safe side?
> 
> Looks conclusive enough to me - if not, Ted, please holler. I'll
> queue it up.

Sounds good, thanks so much Jens!

					- Ted
