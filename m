Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46672 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751299AbeDRVTm (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 18 Apr 2018 17:19:42 -0400
Date: Wed, 18 Apr 2018 17:19:39 -0400
From: Jerome Glisse <jglisse@redhat.com>
To: linux-mm@kvack.org
Cc: lsf-pc@lists.linux-foundation.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-block@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>
Subject: [LSF/MM] schedule suggestion
Message-ID: <20180418211939.GD3476@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Just wanted to suggest to push HMM status down one slot in the
agenda to avoid having FS and MM first going into their own
room and then merging back for GUP and DAX, and re-splitting
after. More over HMM and NUMA talks will be good to have back
to back as they deal with same kind of thing mostly.

So on Monday afternoon GUP in first slot would be nice :)

Just a suggestion

https://docs.google.com/spreadsheets/d/15XFz_Zsklmle--L9CO4-ygCqmSHwBsFPjvjDpiL5qwM/edit#gid=0

Cheers,
J�r�me
