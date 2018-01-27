Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:50914 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751619AbeA0Qcx (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 27 Jan 2018 11:32:53 -0500
Message-ID: <1517070766.3012.16.camel@HansenPartnership.com>
Subject: Re: [LSF/MM TOPIC] Springfield: smart and automated storage
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Jan Tulak <jtulak@redhat.com>, lsf-pc@lists.linux-foundation.org
Cc: linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        Justin Mitchell <jumitche@redhat.com>
Date: Sat, 27 Jan 2018 08:32:46 -0800
In-Reply-To: <CACj3i73kv3w_7JuYUi_iL6_2tVTYmj+HZBStfP6oEshz2Enx1w@mail.gmail.com>
References: <CACj3i73kv3w_7JuYUi_iL6_2tVTYmj+HZBStfP6oEshz2Enx1w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Sat, 2018-01-27 at 09:37 +0100, Jan Tulak wrote:
> Springfield is a collection of projects unifying multiple levels of
> the storage stack and providing a general API for automation, health
> and status monitoring, as well as sane and easy configuration across
> multiple levels of the storage stack. It is a scalable solution,
> working from a single node to large deployments with a mix of base
> metal, containers and VMs. For the first time, it was presented on
> Vault 2017 in a birds of a feather session.
> 
> Springfield builds upon and enhances the existing work of those
> projects:
> * udisks
> * libblockdev
> * blivet
> * libstoragemgmt
> 
> It is a coordinated effort to overcome many of the shortcomings of
> the current situation and provide a unified approach to storage
> management, so there is nothing like a binary or a library with the
> name “Springfield.”
> 
> An example of things we are trying to tackle is a useful storage
> reporting, like notifications about filesystem being full, especially
> with thin provisioning and multiple levels of the storage stack,
> where
> the user-visible status is not a true representation of what is
> happening underneath.
> 
> We want to see how the community sees this effort. What shortcomings
> of the current situation in storage layering can Springfield address
> (is there something we don’t see, but a project like this could
> help)? How would you use it, or what would make it more useful to
> you?

Do you have a link to the project page and the source tree(s)?

James
