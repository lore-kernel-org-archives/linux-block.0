Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:36507 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751977AbdEAP6E (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 1 May 2017 11:58:04 -0400
From: Bart Van Assche <Bart.VanAssche@sandisk.com>
To: "markus@trippelsdorf.de" <markus@trippelsdorf.de>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH cosmetic] Remove trailing newline in elevator switch error
 message
Date: Mon, 1 May 2017 15:58:00 +0000
Message-ID: <1493654279.2665.5.camel@sandisk.com>
References: <20170429053808.GA293@x4> <1493651927.2665.3.camel@sandisk.com>
         <20170501154958.GA291@x4>
In-Reply-To: <20170501154958.GA291@x4>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Mon, 2017-05-01 at 17:49 +0200, markus@trippelsdorf.de wrote:
> On 2017.05.01 at 15:18 +0000, Bart Van Assche wrote:
> > Your patch duplicates the code to remove trailing whitespace which is n=
ot
> > very elegant. Please move the code that removes trailing whitespace fro=
m
> > __elevator_change() into  elv_iosched_store() instead of duplicating it=
.
>=20
> Yes, I thought about it, but the problem is that elevator_change() calls=
=20
> __elevator_change(), too.

Hello Markus,

In kernel v4.11 elevator_change() only has a single caller and that caller
passes an elevator name with no trailing whitespace. I am aware that the
elevator_change() function is exported and hence could be used by out-of-tr=
ee
kernel drivers. However, we do not care about potential behavior changes fo=
r
out-of-tree drivers.

Bart.=
