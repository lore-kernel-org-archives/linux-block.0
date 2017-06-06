Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:27698 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751200AbdFFRKW (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 6 Jun 2017 13:10:22 -0400
From: Bart Van Assche <Bart.VanAssche@sandisk.com>
To: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "ebiggers3@gmail.com" <ebiggers3@gmail.com>
CC: "ebiggers@google.com" <ebiggers@google.com>
Subject: Re: [PATCH] elevator: fix truncation of icq_cache_name
Date: Tue, 6 Jun 2017 17:10:19 +0000
Message-ID: <1496769018.2692.12.camel@sandisk.com>
References: <20170603033551.17261-1-ebiggers3@gmail.com>
In-Reply-To: <20170603033551.17261-1-ebiggers3@gmail.com>
Content-Type: text/plain; charset="windows-1251"
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Fri, 2017-06-02 at 20:35 -0700, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
>=20
> gcc 7.1 reports the following warning:
>=20
>     block/elevator.c: In function =91elv_register=92:
>     block/elevator.c:898:5: warning: =91snprintf=92 output may be truncat=
ed before the last format character [-Wformat-truncation=3D]
>          "%s_io_cq", e->elevator_name);
>          ^~~~~~~~~~
>     block/elevator.c:897:3: note: =91snprintf=92 output between 7 and 22 =
bytes into a destination of size 21
>        snprintf(e->icq_cache_name, sizeof(e->icq_cache_name),
>        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>          "%s_io_cq", e->elevator_name);
>          ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>=20
> The bug is that the name of the icq_cache is 6 characters longer than
> the elevator name, but only ELV_NAME_MAX + 5 characters were reserved
> for it --- so in the case of a maximum-length elevator name, the 'q'
> character in "_io_cq" would be truncated by snprintf().  Fix it by
> reserving ELV_NAME_MAX + 6 characters instead.

Reviewed-by: Bart Van Assche <Bart.VanAssche@sandisk.com>=
