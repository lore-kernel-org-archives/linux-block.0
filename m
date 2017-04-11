Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:10575 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752845AbdDKPTl (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Apr 2017 11:19:41 -0400
From: Bart Van Assche <Bart.VanAssche@sandisk.com>
To: "mb@lightnvm.io" <mb@lightnvm.io>,
        "jg@lightnvm.io" <jg@lightnvm.io>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "javier@cnexlabs.com" <javier@cnexlabs.com>
Subject: Re: [PATCH v5] lightnvn: pblk
Date: Tue, 11 Apr 2017 15:19:36 +0000
Message-ID: <1491923975.2654.4.camel@sandisk.com>
References: <1491921077-9377-1-git-send-email-javier@cnexlabs.com>
In-Reply-To: <1491921077-9377-1-git-send-email-javier@cnexlabs.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Tue, 2017-04-11 at 16:31 +0200, Javier Gonz=E1lez wrote:
> Changes since v4:
> * Rebase on top of Matias' for-4.12/core
> * Fix type implicit conversions reported by sparse (reported by Bart Van
>   Assche)
> * Make error and debug statistics long atomic variables.

Hello Javier,

Thanks for the quick respin. But have you already had a look at the
diagnostics reported by smatch? Smatch reports e.g.

drivers/lightnvm/pblk-rb.c:783: pblk_rb_tear_down_check() error: we previou=
sly assumed 'rb->entries' could be null (see line 779)

on the following code:

	if (rb->entries)
		goto out;

	for (i =3D 0; i < rb->nr_entries; i++) {
		entry =3D &rb->entries[i];

		if (entry->data)
			goto out;
	}

Is that "if (rb->entries)" check correct or should that perhaps been
"if (!rb->entries)"? Smatch is available at http://repo.or.cz/w/smatch.git.

Bart.=
