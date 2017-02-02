Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-qt0-f171.google.com ([209.85.216.171]:36828 "EHLO
        mail-qt0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750903AbdBBJfc (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 2 Feb 2017 04:35:32 -0500
Received: by mail-qt0-f171.google.com with SMTP id k15so19342529qtg.3
        for <linux-block@vger.kernel.org>; Thu, 02 Feb 2017 01:35:31 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CACVXFVNwB48b5WGoR3p_akdsCc9e74TordZ89OaHNC+bdtBP3Q@mail.gmail.com>
References: <CAGvB2rO4MXAmThRaVh5-OUsXJ5bYiDngor5O9KZYvT=Xx7gRZg@mail.gmail.com>
 <CACVXFVNwB48b5WGoR3p_akdsCc9e74TordZ89OaHNC+bdtBP3Q@mail.gmail.com>
From: Suraj Choudhari <surajschoudhari@gmail.com>
Date: Thu, 2 Feb 2017 15:05:30 +0530
Message-ID: <CAGvB2rNtGnbFcconCbG8THjFKCHBj-cjKE9tX61pPLFEYxK0yg@mail.gmail.com>
Subject: Re: Doubt related to immutable biovecs
To: Ming Lei <tom.leiming@gmail.com>
Cc: linux-block <linux-block@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Thanks very much Ming and all !

I referred to multipage bvec patches link and it was indeed good & insightful.

I have few more query related to immutable bvecs & multipage bvecs, in
particular related to 4.4 kernel --

1) My understanding is bi_vcnt can't be used for a cloned BIO because
'bio_clone_fast' does NOT update the bi_vcnt field in the cloned BIO.
Is my understanding correct ?

2)  For a block device driver, is it be safe to use the 'bi_vcnt' of a
BIO that's received from the upper layers, in order to access the
bvecs array, particularly in the '4.4' kernel ?
     - I am thinking it may be safe to access bi_vcnt as long as the
block driver has NOT received a CLONE bio from upper layer.  The
reason I think can be bvecs are not multipage in 4.4. Is my
understanding right ?

Thanks & Regards,
Suraj




On Fri, Jan 20, 2017 at 9:27 PM, Ming Lei <tom.leiming@gmail.com> wrote:
> Hi,
>
> On Fri, Jan 20, 2017 at 9:41 PM, Suraj Choudhari
> <surajschoudhari@gmail.com> wrote:
>> Hello,
>>
>> I've some queries related to accessing the 'bio_vec' and 'bi_vcnt'
>> members in the BIO structure after the kernel changes implemented for
>> the 'immutable biovecs' -
>>
>> Background -
>> -  From the changes done for the immutable biovecs, I understand that
>> the driver code now no longer needs to reference the 'bi_vcnt' and
>> 'bi_io_vec' fields directly. Instead we can use the 'bvec_iter'
>> iterator in order to to access the bio_vec.
>> -  We've iterator functions bio_iter_iovec() and bio_advance_iter() as
>> well, which return us literal 'struct biovecs' taking into account the
>> bi_bvec_done and bi_size values.
>>
>> Doubts  -
>> 1)  Few functions in the block layer and some drivers still directly
>> refer to the 'bi_vcnt' and 'bio_vec' members of the BIO structure
>> [instead of accessing bio_vecs using the bvec_iter iterator].
>> Would there be some changes in the functions to compulsorily use the
>> 'bvec_iter' in order to access bio_vecs?  If yes, are such changes
>
> Generally speaking, yes, it is always better to use iterator helpers.
>
>> related to the 'multipage biovec' feature ?
>
> Yes, it is a must for supporting multipage bvec.
>
>>
>> 2)  Can there be some problem if a driver directly accesses the
>> bi_io_vec [bio_vec] in the bio structure based on the values of bi_idx
>> and bi_vcnt ? [instead of using the bvec_iter iterator].
>
> The direct access can't work any more once switching to multipage bvec,
> and you can find some hint in the following link:
>
> https://lkml.org/lkml/2017/1/15/266
>
> Also .bi_vcnt can't be used for BIO_CLONED bio, and it is very easy
> to make mistakes to access the table directly if someone don't understand
> the iterator details enough.
>
>
> Thanks,
> Ming Lei
