Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_BASE64_TEXT,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 915BFC433E6
	for <linux-block@archiver.kernel.org>; Tue,  9 Mar 2021 14:20:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B15964E21
	for <linux-block@archiver.kernel.org>; Tue,  9 Mar 2021 14:20:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230035AbhCIOTr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 9 Mar 2021 09:19:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:38014 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230052AbhCIOT2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 9 Mar 2021 09:19:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615299567;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WMnwjQ6G+cehWoqFOeWZXdtgT2Ci10BIumvHW+aYPf0=;
        b=cXyJMPOn8j1pZ/8zHMlteMnR/+TKqFCO36qEjfu08hCGpLEXlynG02sEMe7eOqJarFm7Za
        gOOvZcYx/spzPoFzxAVd9fE1edw7m4BBZF2ku2HKsie/8PiJSThzz2La4DGUJisH47s9ic
        DHpdzbOCkV77bP5l1DD1O2uiJ3QNWnA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-167-4XP4ekhTOMmfoXb7ETCiMw-1; Tue, 09 Mar 2021 09:19:23 -0500
X-MC-Unique: 4XP4ekhTOMmfoXb7ETCiMw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5F03010866A0;
        Tue,  9 Mar 2021 14:19:22 +0000 (UTC)
Received: from localhost (ovpn-115-70.ams2.redhat.com [10.36.115.70])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 04B996A037;
        Tue,  9 Mar 2021 14:19:21 +0000 (UTC)
From:   Stefan Hajnoczi <stefanha@redhat.com>
To:     linux-block@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>, Jeff Moyer <jmoyer@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH 2/2] spec: add explicit build dependency on make
Date:   Tue,  9 Mar 2021 14:19:13 +0000
Message-Id: <20210309141913.262131-3-stefanha@redhat.com>
In-Reply-To: <20210309141913.262131-1-stefanha@redhat.com>
References: <20210309141913.262131-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

RmVkb3JhIDM0IGlzIHJlbW92aW5nIG1ha2UgZnJvbSB0aGUgYnVpbGRyb290LiBBbiBleHBsaWNp
dCBkZXBlbmRlbmN5IGlzCm5vdyByZXF1aXJlZDoKaHR0cHM6Ly9mZWRvcmFwcm9qZWN0Lm9yZy93
aWtpL0NoYW5nZXMvUmVtb3ZlX21ha2VfZnJvbV9CdWlsZFJvb3QKCkFkZGluZyBhbiBleHBsaWNp
dCBidWlsZCBkZXBlbmRlbmN5IG9uIG1ha2Ugc2VlbXMgcmVhc29uYWJsZSBhY3Jvc3MgYWxsCnJw
bS1iYXNlZCBkaXN0cm9zLiBJdCB3b24ndCBodXJ0IG9uIGRpc3Ryb3Mgd2hlcmUgbWFrZSBpcyBh
bHdheXMKYXZhaWxhYmxlIGluIHRoZSBidWlsZHJvb3QuCgpTaWduZWQtb2ZmLWJ5OiBTdGVmYW4g
SGFqbm9jemkgPHN0ZWZhbmhhQHJlZGhhdC5jb20+Ci0tLQogbGlidXJpbmcuc3BlYyB8IDEgKwog
MSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspCgpkaWZmIC0tZ2l0IGEvbGlidXJpbmcuc3Bl
YyBiL2xpYnVyaW5nLnNwZWMKaW5kZXggODYwNzA3NC4uMDI2OGQyMyAxMDA2NDQKLS0tIGEvbGli
dXJpbmcuc3BlYworKysgYi9saWJ1cmluZy5zcGVjCkBAIC03LDYgKzcsNyBAQCBTb3VyY2UwOiBo
dHRwczovL2JyaWNrLmtlcm5lbC5kay9zbmFwcy8le25hbWV9LSV7dmVyc2lvbn0udGFyLmd6CiBT
b3VyY2UxOiBodHRwczovL2JyaWNrLmtlcm5lbC5kay9zbmFwcy8le25hbWV9LSV7dmVyc2lvbn0u
dGFyLmd6LmFzYwogVVJMOiBodHRwczovL2dpdC5rZXJuZWwuZGsvY2dpdC9saWJ1cmluZy8KIEJ1
aWxkUmVxdWlyZXM6IGdjYworQnVpbGRSZXF1aXJlczogbWFrZQogCiAlZGVzY3JpcHRpb24KIFBy
b3ZpZGVzIG5hdGl2ZSBhc3luYyBJTyBmb3IgdGhlIExpbnV4IGtlcm5lbCwgaW4gYSBmYXN0IGFu
ZCBlZmZpY2llbnQKLS0gCjIuMjkuMgoK

