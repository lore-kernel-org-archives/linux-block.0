Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-qk0-f180.google.com ([209.85.220.180]:33718 "EHLO
        mail-qk0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750735AbeC2Kho (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 29 Mar 2018 06:37:44 -0400
Received: by mail-qk0-f180.google.com with SMTP id d206so5482281qkb.0
        for <linux-block@vger.kernel.org>; Thu, 29 Mar 2018 03:37:43 -0700 (PDT)
From: Muneendra Kumar M <muneendra.kumar@broadcom.com>
References: 376fb4cd375ea3b71c67cbe9168c0199@mail.gmail.com
In-Reply-To: 376fb4cd375ea3b71c67cbe9168c0199@mail.gmail.com
MIME-Version: 1.0
Date: Thu, 29 Mar 2018 16:07:42 +0530
Message-ID: <4b4851a7c7b5c9587c620f69d4a51ae0@mail.gmail.com>
Subject: RE: query on blk_rq_timed_out
To: linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hi ,
If we call submit_bio/blk_execute_rq and due to some target issues we hit
the blk_rq_timed_out.

In blk_rq_timed_out=C2=A0=C2=A0 =C2=A0__blk_complete_request =C2=A0gets cal=
led only in
BLK_EH_HANDLED case and if q->rq_timed_out_fn doesn=E2=80=99t return
BLK_EH_HANDLED
and returns only BLK_EH_NOT_HANDLED/ BLK_EH_RESET_TIMER.

How will the submit_bio/blk_execute_rq returns from it wait state ?
Will we see the hungtask in this case?

Any help regarding this will help me a lot .

Regards,
Muneendra.
