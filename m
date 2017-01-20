Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-yb0-f176.google.com ([209.85.213.176]:33446 "EHLO
        mail-yb0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751977AbdATNlS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 20 Jan 2017 08:41:18 -0500
Received: by mail-yb0-f176.google.com with SMTP id w194so54026191ybe.0
        for <linux-block@vger.kernel.org>; Fri, 20 Jan 2017 05:41:17 -0800 (PST)
MIME-Version: 1.0
From: Suraj Choudhari <surajschoudhari@gmail.com>
Date: Fri, 20 Jan 2017 19:11:16 +0530
Message-ID: <CAGvB2rO4MXAmThRaVh5-OUsXJ5bYiDngor5O9KZYvT=Xx7gRZg@mail.gmail.com>
Subject: Doubt related to immutable biovecs
To: linux-block@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hello,

I've some queries related to accessing the 'bio_vec' and 'bi_vcnt'
members in the BIO structure after the kernel changes implemented for
the 'immutable biovecs' -

Background -
-  From the changes done for the immutable biovecs, I understand that
the driver code now no longer needs to reference the 'bi_vcnt' and
'bi_io_vec' fields directly. Instead we can use the 'bvec_iter'
iterator in order to to access the bio_vec.
-  We've iterator functions bio_iter_iovec() and bio_advance_iter() as
well, which return us literal 'struct biovecs' taking into account the
bi_bvec_done and bi_size values.

Doubts  -
1)  Few functions in the block layer and some drivers still directly
refer to the 'bi_vcnt' and 'bio_vec' members of the BIO structure
[instead of accessing bio_vecs using the bvec_iter iterator].
Would there be some changes in the functions to compulsorily use the
'bvec_iter' in order to access bio_vecs?  If yes, are such changes
related to the 'multipage biovec' feature ?

2)  Can there be some problem if a driver directly accesses the
bi_io_vec [bio_vec] in the bio structure based on the values of bi_idx
and bi_vcnt ? [instead of using the bvec_iter iterator].

Thanks & Regards,
Suraj
