Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-lf0-f43.google.com ([209.85.215.43]:35349 "EHLO
        mail-lf0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752479AbdATQEI (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 20 Jan 2017 11:04:08 -0500
Received: by mail-lf0-f43.google.com with SMTP id n124so60891922lfd.2
        for <linux-block@vger.kernel.org>; Fri, 20 Jan 2017 08:04:03 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAGvB2rO4MXAmThRaVh5-OUsXJ5bYiDngor5O9KZYvT=Xx7gRZg@mail.gmail.com>
References: <CAGvB2rO4MXAmThRaVh5-OUsXJ5bYiDngor5O9KZYvT=Xx7gRZg@mail.gmail.com>
From: Ming Lei <tom.leiming@gmail.com>
Date: Fri, 20 Jan 2017 23:57:12 +0800
Message-ID: <CACVXFVNwB48b5WGoR3p_akdsCc9e74TordZ89OaHNC+bdtBP3Q@mail.gmail.com>
Subject: Re: Doubt related to immutable biovecs
To: Suraj Choudhari <surajschoudhari@gmail.com>
Cc: linux-block <linux-block@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hi,

On Fri, Jan 20, 2017 at 9:41 PM, Suraj Choudhari
<surajschoudhari@gmail.com> wrote:
> Hello,
>
> I've some queries related to accessing the 'bio_vec' and 'bi_vcnt'
> members in the BIO structure after the kernel changes implemented for
> the 'immutable biovecs' -
>
> Background -
> -  From the changes done for the immutable biovecs, I understand that
> the driver code now no longer needs to reference the 'bi_vcnt' and
> 'bi_io_vec' fields directly. Instead we can use the 'bvec_iter'
> iterator in order to to access the bio_vec.
> -  We've iterator functions bio_iter_iovec() and bio_advance_iter() as
> well, which return us literal 'struct biovecs' taking into account the
> bi_bvec_done and bi_size values.
>
> Doubts  -
> 1)  Few functions in the block layer and some drivers still directly
> refer to the 'bi_vcnt' and 'bio_vec' members of the BIO structure
> [instead of accessing bio_vecs using the bvec_iter iterator].
> Would there be some changes in the functions to compulsorily use the
> 'bvec_iter' in order to access bio_vecs?  If yes, are such changes

Generally speaking, yes, it is always better to use iterator helpers.

> related to the 'multipage biovec' feature ?

Yes, it is a must for supporting multipage bvec.

>
> 2)  Can there be some problem if a driver directly accesses the
> bi_io_vec [bio_vec] in the bio structure based on the values of bi_idx
> and bi_vcnt ? [instead of using the bvec_iter iterator].

The direct access can't work any more once switching to multipage bvec,
and you can find some hint in the following link:

https://lkml.org/lkml/2017/1/15/266

Also .bi_vcnt can't be used for BIO_CLONED bio, and it is very easy
to make mistakes to access the table directly if someone don't understand
the iterator details enough.


Thanks,
Ming Lei
