Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:62074 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751473AbdEDXRZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 4 May 2017 19:17:25 -0400
From: Bart Van Assche <Bart.VanAssche@sandisk.com>
To: "osandov@osandov.com" <osandov@osandov.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "axboe@fb.com" <axboe@fb.com>
CC: "kernel-team@fb.com" <kernel-team@fb.com>
Subject: Re: [PATCH v2 11/12] kyber: add debugfs attributes
Date: Thu, 4 May 2017 23:17:20 +0000
Message-ID: <1493939840.2692.18.camel@sandisk.com>
References: <cover.1493882751.git.osandov@fb.com>
         <13ff6ed57d5acc649cb34415596bfd75c96471eb.1493882751.git.osandov@fb.com>
In-Reply-To: <13ff6ed57d5acc649cb34415596bfd75c96471eb.1493882751.git.osandov@fb.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Thu, 2017-05-04 at 00:31 -0700, Omar Sandoval wrote:
> +#define KYBER_DEBUGFS_DOMAIN_ATTRS(domain, name)

Hello Omar,

That's a really long macro name. Have you considered to leave out "_DOMAIN"
from the name of this and related macros?

Bart.=
