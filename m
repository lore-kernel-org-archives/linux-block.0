Return-Path: <SRS0=Qtc1=YI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 004EFECE59D
	for <linux-block@archiver.kernel.org>; Tue, 15 Oct 2019 22:11:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D012120854
	for <linux-block@archiver.kernel.org>; Tue, 15 Oct 2019 22:11:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733150AbfJOWL2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 15 Oct 2019 18:11:28 -0400
Received: from namei.org ([65.99.196.166]:54374 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726231AbfJOWL2 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 15 Oct 2019 18:11:28 -0400
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id x9FMB7We018105;
        Tue, 15 Oct 2019 22:11:07 GMT
Date:   Wed, 16 Oct 2019 09:11:07 +1100 (AEDT)
From:   James Morris <jmorris@namei.org>
To:     David Howells <dhowells@redhat.com>
cc:     torvalds@linux-foundation.org,
        Casey Schaufler <casey@schaufler-ca.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        nicolas.dichtel@6wind.com, raven@themaw.net,
        Christian Brauner <christian@brauner.io>,
        keyrings@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-block@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 00/21] pipe: Keyrings, Block and USB notifications
In-Reply-To: <157117606853.15019.15459271147790470307.stgit@warthog.procyon.org.uk>
Message-ID: <alpine.LRH.2.21.1910160909230.11167@namei.org>
References: <157117606853.15019.15459271147790470307.stgit@warthog.procyon.org.uk>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, 15 Oct 2019, David Howells wrote:

> 
> Here's a set of patches to add a general notification queue concept and to
> add event sources such as:

On the next iteration, please include the rationale for this per your 
previous posting: https://lkml.org/lkml/2019/9/5/857


-- 
James Morris
<jmorris@namei.org>

