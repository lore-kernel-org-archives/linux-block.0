Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-io0-f176.google.com ([209.85.223.176]:35658 "EHLO
	mail-io0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752496AbcF1OCe (ORCPT
	<rfc822;linux-block@vger.kernel.org>);
	Tue, 28 Jun 2016 10:02:34 -0400
Received: by mail-io0-f176.google.com with SMTP id f30so17412412ioj.2
        for <linux-block@vger.kernel.org>; Tue, 28 Jun 2016 07:02:34 -0700 (PDT)
MIME-Version: 1.0
From: yoma sophian <sophian.yoma@gmail.com>
Date: Tue, 28 Jun 2016 22:02:33 +0800
Message-ID: <CADUS3o=5hs0Bb4Vh_WHyk9_9bDiGRkkmvN0VF-1nLf2+H5gxCg@mail.gmail.com>
Subject: some question about block end functions
To: linux-block@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

hi all:
blk_end_request_all will call blk_end_bidi_request for updating not
only current request, but rq->next_rq as well.
    Per my understanding, driver will fetch request one by one from
queue to finish transferring data.
    under what circumstance, driver will use blk_end_request_all for
updating current and next request?

appreciate your kind help in advance,
