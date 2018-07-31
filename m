Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:35804 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728187AbeGaJ3m (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 31 Jul 2018 05:29:42 -0400
Date: Tue, 31 Jul 2018 00:50:39 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Li Dongyang <dongyangli@ddn.com>
Cc: linux-block@vger.kernel.org, adilger@dilger.ca, lixi@ddn.com,
        martin.petersen@oracle.com, sihara@ddn.com
Subject: Re: [PATCH 1/2] block-integrity: allow optional integrity functions
 for bio
Message-ID: <20180731075039.GA10387@infradead.org>
References: <20180731071938.22129-1-dongyangli@ddn.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180731071938.22129-1-dongyangli@ddn.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Please submit these together with an actual user.  We are not
going to add dead code to the kernel.  Even with an actual user
you'll need a reall good argument for bloating struct bio.
