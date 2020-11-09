Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2623BC4741F
	for <linux-block@archiver.kernel.org>; Mon,  9 Nov 2020 16:11:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CFE7F2074F
	for <linux-block@archiver.kernel.org>; Mon,  9 Nov 2020 16:11:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aF1T2Bav"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729243AbgKIQL6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 9 Nov 2020 11:11:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:44063 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730032AbgKIQL4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 9 Nov 2020 11:11:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604938313;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type;
        bh=P94me2jyBMT+QV4CBp9rgOh9LQSoCcaOputEOuvqNg4=;
        b=aF1T2BavpSbKyZmJUrPglX6iAq5gzNYZtUkx9+T9HAd9U4Wg6GEYV4jLQ0RgUAIh8MA9dZ
        csVtstNYoGn1wGCye74O5ELWE6RwEOH1ijYGKuJaTKNR9xuDl1oiHMOm/858+uJa9HC6Vw
        14SXaL9MkuBLPhTxI/KHwI9QbphtvtQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-450-7VNdJMKSOmmLVXj36h9TMA-1; Mon, 09 Nov 2020 11:11:50 -0500
X-MC-Unique: 7VNdJMKSOmmLVXj36h9TMA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 72E1111CC7E3;
        Mon,  9 Nov 2020 16:11:49 +0000 (UTC)
Received: from [172.20.12.25] (unknown [10.0.115.152])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9D6BE2C31E;
        Mon,  9 Nov 2020 16:11:45 +0000 (UTC)
MIME-Version: 1.0
From:   CKI Project <cki-project@redhat.com>
To:     linux-block@vger.kernel.org, axboe@kernel.dk
Subject: =?utf-8?b?4p2M?= FAIL: Test report for kernel 5.10.0-rc3 (block)
Date:   Mon, 09 Nov 2020 16:11:45 -0000
Message-ID: <cki.F35EC3202F.1TPV9ZC6SF@redhat.com>
X-Gitlab-Pipeline-ID: 617345
X-Gitlab-Url: https://xci32.lab.eng.rdu2.redhat.com/
X-Gitlab-Path: /cki-project/cki-pipeline/pipelines/617345
Content-Type: multipart/mixed; boundary="===============7696941214202642069=="
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

--===============7696941214202642069==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable


Hello,

We ran automated tests on a recent commit from this kernel tree:

       Kernel repo: https://git.kernel.org/pub/scm/linux/kernel/git/axboe/lin=
ux-block.git
            Commit: c91882ba0790 - Merge branch 'tif-task_work.arch' into for=
-next

The results of these automated tests are provided below.

    Overall result: FAILED (see details below)
             Merge: OK
           Compile: FAILED

All kernel binaries, config files, and logs are available for download here:

  https://arr-cki-prod-datawarehouse-public.s3.amazonaws.com/index.html?prefi=
x=3Ddatawarehouse-public/2020/11/09/617345

We attempted to compile the kernel for multiple architectures, but the compile
failed on one or more architectures:

            x86_64: FAILED (see build-x86_64.log.xz attachment)

We hope that these logs can help you find the problem quickly. For the full
detail on our testing procedures, please scroll to the bottom of this message.

Please reply to this email if you have any questions about the tests that we
ran or if you have any suggestions on how to make future tests more effective.

        ,-.   ,-.
       ( C ) ( K )  Continuous
        `-',-.`-'   Kernel
          ( I )     Integration
           `-'
______________________________________________________________________________

Compile testing
---------------

We compiled the kernel for 4 architectures:

    aarch64:
      make options: make -j30 INSTALL_MOD_STRIP=3D1 targz-pkg

    ppc64le:
      make options: make -j30 INSTALL_MOD_STRIP=3D1 targz-pkg

    s390x:
      make options: make -j30 INSTALL_MOD_STRIP=3D1 targz-pkg

    x86_64:
      make options: make -j30 INSTALL_MOD_STRIP=3D1 targz-pkg



--===============7696941214202642069==
Content-Type: application/x-xz
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="build-x86_64.log.xz"
MIME-Version: 1.0

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

--===============7696941214202642069==--

