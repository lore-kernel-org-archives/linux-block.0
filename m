Return-Path: <SRS0=Ukdl=Y7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB9B8C5DF61
	for <linux-block@archiver.kernel.org>; Thu,  7 Nov 2019 13:37:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8138121D7E
	for <linux-block@archiver.kernel.org>; Thu,  7 Nov 2019 13:37:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aog027kh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389308AbfKGNhc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 7 Nov 2019 08:37:32 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:21690 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728687AbfKGNhc (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 7 Nov 2019 08:37:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573133851;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8DBEB3dxz4nhTkQa22lSussK6HcKkhYzbxWxJFWaoS8=;
        b=aog027khoO9m8erMkKi1iCmQkzrYFoT+HrkK9/JpANPsVpmCIWvaoXI7beahPt82FfyGve
        9uzhm0urB1GQ9BB4R3BgjmUTEfQGshkN7GtaFwsbuv8MHFTDhsSLMtqAyyeamy6YR/Hv6g
        35UsxilqMtNVe+oTFqPgwpdXgCTWrp4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-310-sZ_L33zXMNOrElkX2stpsg-1; Thu, 07 Nov 2019 08:37:28 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3059A107ACC3;
        Thu,  7 Nov 2019 13:37:25 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-254.rdu2.redhat.com [10.10.120.254])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9873260CD3;
        Thu,  7 Nov 2019 13:37:21 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [RFC PATCH 13/14] selinux: Implement the watch_key security hook
 [ver #2]
From:   David Howells <dhowells@redhat.com>
To:     torvalds@linux-foundation.org
Cc:     dhowells@redhat.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Stephen Smalley <sds@tycho.nsa.gov>, nicolas.dichtel@6wind.com,
        raven@themaw.net, Christian Brauner <christian@brauner.io>,
        dhowells@redhat.com, keyrings@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-block@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 07 Nov 2019 13:37:20 +0000
Message-ID: <157313384065.29677.12354003434069581212.stgit@warthog.procyon.org.uk>
In-Reply-To: <157313371694.29677.15388731274912671071.stgit@warthog.procyon.org.uk>
References: <157313371694.29677.15388731274912671071.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: sZ_L33zXMNOrElkX2stpsg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Implement the watch_key security hook to make sure that a key grants the
caller View permission in order to set a watch on a key.

For the moment, the watch_devices security hook is left unimplemented as
it's not obvious what the object should be since the queue is global and
didn't previously exist.

Signed-off-by: David Howells <dhowells@redhat.com>
Acked-by: Stephen Smalley <sds@tycho.nsa.gov>
---

 security/selinux/hooks.c |   14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 9625b99e677f..53637dccee00 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -6579,6 +6579,17 @@ static int selinux_key_getsecurity(struct key *key, =
char **_buffer)
 =09*_buffer =3D context;
 =09return rc;
 }
+
+#ifdef CONFIG_KEY_NOTIFICATIONS
+static int selinux_watch_key(struct key *key)
+{
+=09struct key_security_struct *ksec =3D key->security;
+=09u32 sid =3D current_sid();
+
+=09return avc_has_perm(&selinux_state,
+=09=09=09    sid, ksec->sid, SECCLASS_KEY, KEY_NEED_VIEW, NULL);
+}
+#endif
 #endif
=20
 #ifdef CONFIG_SECURITY_INFINIBAND
@@ -7012,6 +7023,9 @@ static struct security_hook_list selinux_hooks[] __ls=
m_ro_after_init =3D {
 =09LSM_HOOK_INIT(key_free, selinux_key_free),
 =09LSM_HOOK_INIT(key_permission, selinux_key_permission),
 =09LSM_HOOK_INIT(key_getsecurity, selinux_key_getsecurity),
+#ifdef CONFIG_KEY_NOTIFICATIONS
+=09LSM_HOOK_INIT(watch_key, selinux_watch_key),
+#endif
 #endif
=20
 #ifdef CONFIG_AUDIT

