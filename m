Return-Path: <SRS0=gQfC=TF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CF14C04AAB
	for <linux-block@archiver.kernel.org>; Sun,  5 May 2019 22:23:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51294205C9
	for <linux-block@archiver.kernel.org>; Sun,  5 May 2019 22:23:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="H/Yd9o43"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727325AbfEEWXc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 5 May 2019 18:23:32 -0400
Received: from mout.gmx.net ([212.227.17.21]:57731 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726905AbfEEWXc (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sun, 5 May 2019 18:23:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1557095009;
        bh=0to9aQztkzngPNOMzshiFNlFaZiT59rL6T6hAiU2bZI=;
        h=X-UI-Sender-Class:Date:From:To:Subject;
        b=H/Yd9o43WYU/q0jDfpt5+ijb9eg5X3yvB2rbW8TVBSCwZi/hSpjqBSXh8V3N4y8fK
         uMEFrnaiVneqrFRAa2LlClkajiKVPnUdbbpVwPC1VyzoJgyxW7tGK/rDGeSww6A8SM
         w3qa3qITxnYV5MQ9QTME6gT9uBADYzC3Af4mk32g=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from ls3530.dellerweb.de ([92.116.187.88]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LqW8j-1gsUi13ozR-00e5uF; Mon, 06
 May 2019 00:23:29 +0200
Date:   Mon, 6 May 2019 00:23:27 +0200
From:   Helge Deller <deller@gmx.de>
To:     Philipp Reisner <philipp.reisner@linbit.com>,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        Jens Axboe <axboe@kernel.dk>, drbd-dev@lists.linbit.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drbd: Rename LEVEL to VLI_LEVEL to avoid name clash
Message-ID: <20190505222327.GA32268@ls3530.dellerweb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Provags-ID: V03:K1:UjfJ4usowKn/6EYdHyPsJ9a4AFua2i4rNp/24cGOEtp8M1nChUG
 WXmQXWJgYhK4GzkSqdanbOkJqxa4+mr49LW517/ufiCvTJSsmJvcZNy/92FtvjnLZCSNYyK
 bNSEeVbuPWIUlI/cYQ0SN66HDUmZw2YdgCfkA5GcJAoysv+nSNSUxGM+TkmRYhXvMcEBucD
 Wb46SPqW602Os9WrhI8+g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:F9j4RhW32lM=:/6xtdpiXI3/sGIoeZ0GNx0
 /1zbs9ZLxX2gz8XPgzDrG0Bq7VxklD0EQW91Wi7QMe0MdB/uJnchupKf30FIftv3YoStqFHtS
 Iu35BmM0vIePIHcyctkpmV1ww1INO/utLjs8/kxJ60rUKnjbLmmBzSfRcFW/WbjKqp/nyfhjI
 MKB2z116ya5+8rskTdhgv/sjlCxyyPUCog1s1iu4mngladLwCClMaZg8dzV7/2r/k4lF8Wb4L
 xZJFWdZYlQ3+C38hE4d5mPZa3cH8wc9LZWWlNWZpa/cpkSKoeR5ahYK6zanxXMHelVxRRwcWq
 r73cDw0gxjc0A53TLpnvvajHJjb5awMSTsb09myoyhNCl5zYawQXvvygndCl/HD+u+jfistsm
 Eb2rnunXPvsjftC4McU9HhzHbYCctaRG/N1XA46v+wvae7P2zsyVjWNrDpvMm3DpQAw9V95LE
 5WESkNHXAkqVlM3/zS40eSxeOaxwpbLGE7d80XLkwpcplivlIZRhQhv33DmzAZ4loLb72es8c
 24UN7pPupER2Bg79y2g3+23I92LFYNOK2DpHVluhRP+/0JqTCm1+A6/63mcVPJCa/wtOmRBQw
 Ax9+zTzc4uQmlDRvmM9I4tylFEIjfWJLsoxZBsi4QWOeQxSoZzeMV1I3Wu+0mUojhGjO/mqYy
 J1GvlaUHbM+nvehHRNDTUiim9DN9IAynMgsLirFlafAwIgFiB1pfQnWAF9SB1OB1OxjQBv2Fv
 LDAsQcSIX41/zOoA44EHI7GADseNXQB3iSuNTgIZTrBzmwYy5Bfs4Tk2m1jl4ePqvDlPk8A8l
 CU3bYnHPNsatNuFDo3ZYkMRgNIbP5ldCRmPWrz02lbAdycXQKc3ld8GMl6N/SWf9E7VOjRXDX
 o1wQoiyuxDFpFY6c9prq47ldkyn36g/4/WLLinmSXeW9+HizSvIe4O1bn0yRij
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Using a generic word like LEVEL is bad idea - it can easily clash with ano=
ther
LEVEL defined somewhere else.
In this case, it clashed with the LEVEL defined in arch/parisc/include/asm=
/assembly.h
when the header file got included via jump_level.h.

This patch replaces the LEVEL defined in drbd_vli.h by VLI_LEVEL.
Another patch renames the LEVEL defined in arch/parisc/include/asm/assembl=
y.h.

Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Helge Deller <deller@gmx.de>

diff --git a/drivers/block/drbd/drbd_vli.h b/drivers/block/drbd/drbd_vli.h
index 8cb1532a3816..d7ced8626035 100644
=2D-- a/drivers/block/drbd/drbd_vli.h
+++ b/drivers/block/drbd/drbd_vli.h
@@ -121,22 +121,22 @@ prefix    data bits                                 =
   max val  N=BA data bits
  1             16              32                              64
 */

-/* LEVEL: (total bits, prefix bits, prefix value),
+/* VLI_LEVEL: (total bits, prefix bits, prefix value),
  * sorted ascending by number of total bits.
  * The rest of the code table is calculated at compiletime from this. */

 /* fibonacci data 1, 1, ... */
 #define VLI_L_1_1() do { \
-	LEVEL( 2, 1, 0x00); \
-	LEVEL( 3, 2, 0x01); \
-	LEVEL( 5, 3, 0x03); \
-	LEVEL( 7, 4, 0x07); \
-	LEVEL(10, 5, 0x0f); \
-	LEVEL(14, 6, 0x1f); \
-	LEVEL(21, 8, 0x3f); \
-	LEVEL(29, 8, 0x7f); \
-	LEVEL(42, 8, 0xbf); \
-	LEVEL(64, 8, 0xff); \
+	VLI_LEVEL( 2, 1, 0x00); \
+	VLI_LEVEL( 3, 2, 0x01); \
+	VLI_LEVEL( 5, 3, 0x03); \
+	VLI_LEVEL( 7, 4, 0x07); \
+	VLI_LEVEL(10, 5, 0x0f); \
+	VLI_LEVEL(14, 6, 0x1f); \
+	VLI_LEVEL(21, 8, 0x3f); \
+	VLI_LEVEL(29, 8, 0x7f); \
+	VLI_LEVEL(42, 8, 0xbf); \
+	VLI_LEVEL(64, 8, 0xff); \
 	} while (0)

 /* finds a suitable level to decode the least significant part of in.
@@ -147,7 +147,7 @@ static inline int vli_decode_bits(u64 *out, const u64 =
in)
 {
 	u64 adj =3D 1;

-#define LEVEL(t,b,v)					\
+#define VLI_LEVEL(t,b,v)				\
 	do {						\
 		if ((in & ((1 << b) -1)) =3D=3D v) {	\
 			*out =3D ((in & ((~0ULL) >> (64-t))) >> b) + adj;	\
@@ -160,7 +160,7 @@ static inline int vli_decode_bits(u64 *out, const u64 =
in)

 	/* NOT REACHED, if VLI_LEVELS code table is defined properly */
 	BUG();
-#undef LEVEL
+#undef VLI_LEVEL
 }

 /* return number of code bits needed,
@@ -173,7 +173,7 @@ static inline int __vli_encode_bits(u64 *out, const u6=
4 in)
 	if (in =3D=3D 0)
 		return -EINVAL;

-#define LEVEL(t,b,v) do {		\
+#define VLI_LEVEL(t,b,v) do {		\
 		max +=3D 1ULL << (t - b);	\
 		if (in <=3D max) {	\
 			if (out)	\
@@ -186,7 +186,7 @@ static inline int __vli_encode_bits(u64 *out, const u6=
4 in)
 	VLI_L_1_1();

 	return -EOVERFLOW;
-#undef LEVEL
+#undef VLI_LEVEL
 }

 #undef VLI_L_1_1
